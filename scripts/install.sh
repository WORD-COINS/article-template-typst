#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/lib.sh"

declare -A missing_fonts=()

if ! command -v unzip >/dev/null 2>&1; then
  printf "%bunzip is required to run this script%b\n" "$YELLOW" "$RESET"
  exit 1
fi

if ! command -v wget >/dev/null 2>&1; then
  printf "%bwget is required to run this script%b\n" "$YELLOW" "$RESET"
  exit 1
fi

while IFS='=' read -r name url; do
  missing_fonts["$name"]="$url"
done < <(read_font_entries)

mkdir -p fonts

# TODO: consider multithread
for name in "${!missing_fonts[@]}"; do
  echo "Download ${name}..."
  # Create temporary directory for each font
  TEMP_DIR=$(mktemp -d)
  trap 'rm -rf "$TEMP_DIR"' EXIT

  wget -q "${missing_fonts[$name]}" -P "$TEMP_DIR/"

  shopt -s nullglob
  zip_files=("$TEMP_DIR"/*.zip)
  shopt -u nullglob

  for zip_file in "${zip_files[@]}"; do
    echo "Unzipping ${zip_file}..."
    if ! unzip -q "$zip_file" -d "$TEMP_DIR/"; then
      printf "%b[WARN]%b Failed to unzip %s\n" "$YELLOW" "$RESET" "$zip_file" >&2
    fi
  done

  find "$TEMP_DIR" -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp {} fonts/ \;

  rm -rf "$TEMP_DIR"
  trap - EXIT
done
