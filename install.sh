#!/bin/sh
set -eu

version=0.5.0
release_base=https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.5.0
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
  darwin_amd64) expected_sha256=8aa3a4c9c00168c74730c001496a229206a766cbd5de99c84c9eb3ac1043a52f ;;
  darwin_arm64) expected_sha256=29fd9210d1eb82ba35ebb3c3f42c32fb03087075ea16dc7696caa9fc429ddad6 ;;
  linux_amd64) expected_sha256=454291c2ca0fa6aff4be2ce781f2cbc1284a9d9223a3b5c6170f6e21c49c05e2 ;;
  linux_arm64) expected_sha256=38fcdeee5838d626e1d0269c9319579d2083eb75001af773a2cc30bdd2212e1e ;;
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
