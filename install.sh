#!/bin/sh
set -eu

version=0.8.1
release_base=https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.1
default_install_directory="${HOME:?HOME must be set}/.local/bin"
install_directory="${CANTELOP_INSTALL_DIR:-$default_install_directory}"

file_has_line() {
  file=$1
  wanted=$2
  [ -f "$file" ] || return 1
  while IFS= read -r existing_line || [ -n "$existing_line" ]; do
    [ "$existing_line" = "$wanted" ] && return 0
  done <"$file"
  return 1
}

configure_path() {
  case ":${PATH:-}:" in
    *":${install_directory}:"*) return ;;
  esac
  if [ -n "${CANTELOP_NO_MODIFY_PATH:-}" ]; then
    echo "$install_directory is not on PATH; profile update skipped by CANTELOP_NO_MODIFY_PATH."
    return
  fi
  if [ "$install_directory" != "$default_install_directory" ]; then
    echo "$install_directory is not on PATH; add this custom directory to your shell profile."
    return
  fi

  shell_name=${SHELL##*/}
  case "$shell_name" in
    zsh)
      profile="$HOME/.zshrc"
      profile_line='export PATH="$HOME/.local/bin:$PATH" # added by cantelop installer'
      ;;
    bash)
      if [ "$(uname -s)" = Darwin ]; then
        profile="$HOME/.bash_profile"
      else
        profile="$HOME/.bashrc"
      fi
      profile_line='export PATH="$HOME/.local/bin:$PATH" # added by cantelop installer'
      ;;
    fish)
      profile="${XDG_CONFIG_HOME:-$HOME/.config}/fish/conf.d/cantelop.fish"
      profile_line='set -gx PATH "$HOME/.local/bin" $PATH # added by cantelop installer'
      ;;
    *)
      profile="$HOME/.profile"
      profile_line='export PATH="$HOME/.local/bin:$PATH" # added by cantelop installer'
      ;;
  esac

  mkdir -p "${profile%/*}"
  if file_has_line "$profile" "$profile_line"; then
    echo "$default_install_directory is already configured in $profile."
  elif printf '
%s
' "$profile_line" >>"$profile"; then
    echo "Added $default_install_directory to PATH in $profile."
  else
    echo "Could not update $profile; add $default_install_directory to PATH manually." >&2
    return
  fi
  echo "Restart your shell, or run: . $profile"
}

for command in curl tar install; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "cantelop installer requires $command" >&2
    exit 1
  fi
done

case "$install_directory" in
  /*) ;;
  *) echo "CANTELOP_INSTALL_DIR must be an absolute path" >&2; exit 1 ;;
esac

existing_cantelop="$(command -v cantelop 2>/dev/null || true)"
if [ -n "$existing_cantelop" ] && [ "$existing_cantelop" != "$install_directory/cantelop" ]; then
  echo "cantelop is already installed at $existing_cantelop" >&2
  echo "Remove the existing installation before installing another copy." >&2
  exit 1
fi

case "$(uname -s)" in
  Darwin) operating_system=darwin ;;
  Linux) operating_system=linux ;;
  *) echo "cantelop does not support operating system: $(uname -s)" >&2; exit 1 ;;
esac

case "$(uname -m)" in
  x86_64|amd64) architecture=amd64 ;;
  arm64|aarch64) architecture=arm64 ;;
  *) echo "cantelop does not support architecture: $(uname -m)" >&2; exit 1 ;;
esac

platform="${operating_system}_${architecture}"
case "$platform" in
  darwin_amd64) expected_sha256=8ae75f8c5c581ba6bdde946d4c59c4a09e777882a803bc3e6798031ac9f36aba ;;
  darwin_arm64) expected_sha256=9bedd38f53bea258ec80d7648991605a23d8323bb862afcbff1e1ae36eba15b6 ;;
  linux_amd64) expected_sha256=59a80b3bacfd22b56347732d6ea0d5311ee7d3f5128cc8f7aea8b8bba30e2671 ;;
  linux_arm64) expected_sha256=6406eee978a25cc29eed601c073fae0a73be64a8fa03144d86110cd3c0b8ef8b ;;
  *) echo "cantelop does not provide an archive for $platform" >&2; exit 1 ;;
esac

archive="cantelop_${version}_${platform}.tar.gz"
temporary_directory="$(mktemp -d "${TMPDIR:-/tmp}/cantelop-install.XXXXXX")"
staged_path="${install_directory}/.cantelop.$$"
trap 'rm -rf "$temporary_directory"; rm -f "$staged_path"' 0 HUP INT TERM

curl --fail --silent --show-error --location --proto '=https' --proto-redir '=https'   --output "${temporary_directory}/${archive}"   "${release_base}/${archive}"

if command -v sha256sum >/dev/null 2>&1; then
  printf '%s  %s
' "$expected_sha256" "$archive"     | (cd "$temporary_directory" && sha256sum --check --status -)
elif command -v shasum >/dev/null 2>&1; then
  printf '%s  %s
' "$expected_sha256" "$archive"     | (cd "$temporary_directory" && shasum -a 256 --check --status -)
else
  echo "cantelop installer requires sha256sum or shasum" >&2
  exit 1
fi

tar -C "$temporary_directory" -xzf "${temporary_directory}/${archive}" cantelop
actual_version="$("${temporary_directory}/cantelop" version)"
case "$actual_version" in
  "cantelop $version ("????????????")") ;;
  *) echo "downloaded CLI reported an unexpected version: $actual_version" >&2; exit 1 ;;
esac

mkdir -p "$install_directory"
install -m 0755 "${temporary_directory}/cantelop" "$staged_path"
mv -f "$staged_path" "${install_directory}/cantelop"

echo "Installed cantelop $version to ${install_directory}/cantelop"
configure_path
