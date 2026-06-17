# Colour definitions
RED='\033[31m'
YELLOW='\033[33m'
GREEN='\033[32m'
CYAN='\033[36m'
BOLD='\033[1m'
RESET='\033[0m'

trim() {
  local value="$1"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  printf '%s' "$value"
}

read_font_entries() {
  local raw_name raw_url name url

  while IFS='=' read -r raw_name raw_url || [[ -n "${raw_name:-}" ]]; do
    name="$(trim "${raw_name:-}")"
    url="$(trim "${raw_url:-}")"

    [[ -z "$name" || "${name:0:1}" = "#" ]] && continue

    printf '%s=%s\n' "$name" "$url"
  done
}

lowercase() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]'
}
