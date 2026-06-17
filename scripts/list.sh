#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/lib.sh"

installed_families="$(typst fonts --font-path=fonts | tr '[:upper:]' '[:lower:]')"

while IFS='=' read -r name url; do
  key="$(lowercase "$name")"
  if ! printf '%s\n' "$installed_families" | grep -Fxq "$key"; then
    echo "${name}=${url}"
  fi
done < <(read_font_entries < "$SCRIPT_DIR/fonts.list")
