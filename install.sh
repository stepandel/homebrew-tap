#!/bin/sh
set -eu

version=0.10.0
release_base=https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.10.0
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
  darwin_amd64) expected_sha256=016a76852dd915377323efb3707f0f72432a3b7c374034f38ceb83b612be5936 ;;
  darwin_arm64) expected_sha256=d05af7f36ee78773ae012d53304fb40d58fe82d1fb6c3f0e268324ac2b64766d ;;
  linux_amd64) expected_sha256=c21c4b8921f4aa94588fba6d1ec92314ef7e0a21e4669b3c20e7f4cd37db83dd ;;
  linux_arm64) expected_sha256=eead7734e4991cd4c76a09e3d9be2e9ebdbee6d769d36d243ae1332a7ceec235 ;;
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
