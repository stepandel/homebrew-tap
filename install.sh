#!/bin/sh
set -eu

version=0.3.2
release_base=https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.2
install_directory="${CANTELOP_INSTALL_DIR:-${HOME:?HOME must be set}/.local/bin}"

for command in curl tar install; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "cantelop installer requires $command" >&2
    exit 1
  fi
done

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
  darwin_amd64) expected_sha256=b45b1d55146eb0d6092e279d06280de147baba3a86f2f64b4226c8e85917a61c ;;
  darwin_arm64) expected_sha256=bdfda8fbf4faafa29e1e504c984c419d0f77b076827b32198a6d17e999aebd1b ;;
  linux_amd64) expected_sha256=8b1942ec7d7387bca3ca1682d765f7363fcf5c74886fa369892f6ddb9dc8407a ;;
  linux_arm64) expected_sha256=5e9c3a3286d27020ceec39fbff22d2eef1c3a45b90600487d05f9170ec0bca42 ;;
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
case ":${PATH:-}:" in
  *":${install_directory}:"*) ;;
  *) echo "Add $install_directory to PATH to run cantelop." ;;
esac
