#!/bin/sh
set -eu

version=0.3.1
release_base=https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.1
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
  darwin_amd64) expected_sha256=6ba22d0f2d211c64b8c83fabb5be166e927cdea25ba3815dec3298a4108a11c7 ;;
  darwin_arm64) expected_sha256=11346b8051a63032554d53e5b31340144902ca530b1d00dfbc846972f7b2be95 ;;
  linux_amd64) expected_sha256=861ae0dd712161c4e065d149082eb849c21fa999e7027f544852c1897365d3d4 ;;
  linux_arm64) expected_sha256=5f178bdaff8d8a437f53926e59e1b6ba67d30c9cb76eaef5e512b5b072cfc18d ;;
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
