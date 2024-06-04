print_ok() {
    GREEN_COLOR="\033[0;32m"
    DEFAULT="\033[0m"
    echo -e "${GREEN_COLOR} ✔ [OK]    ${1:-} ${DEFAULT}"
}

print_warning() {
    YELLOW_COLOR="\033[33m"
    DEFAULT="\033[0m"
    echo -e "${YELLOW_COLOR} ⚠ [WARN]  ${1:-} ${DEFAULT}"
}

print_info() {
    BLUE_COLOR="\033[0;34m"
    DEFAULT="\033[0m"
    echo -e "${BLUE_COLOR}  [INFO]  ${1:-} ${DEFAULT}"
}

print_fail() {
    RED_COLOR="\033[0;31m"
    DEFAULT="\033[0m"
    echo -e "${RED_COLOR}  [ERROR] ${1:-}${DEFAULT}"
}
