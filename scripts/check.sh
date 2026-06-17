#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$SCRIPT_DIR/lib.sh"

declare -A missing_fonts=()

while IFS='=' read -r name url; do
  missing_fonts["$name"]="$url"
done < <(read_font_entries)


# If any input arrived, treat each as a missing font and emit a warning
if (( ${#missing_fonts[@]} )); then
  for font in "${!missing_fonts[@]}"; do
    printf "%b• %b${BOLD}%s${RESET}%b is missing\n" \
      "$RED" "" "$font" "$RED"
    printf "   → Download at: %b%s%b\n" \
      "$CYAN" "${missing_fonts[$font]}" "$RESET"
  done
  printf "\n%b%d font(s) is missing%b\n" \
    "$YELLOW" "${#missing_fonts[@]}" "$RESET"
  exit 1
else
  printf "%b✓ All required fonts are available!%b\n" \
    "$GREEN$BOLD" "$RESET"
fi
