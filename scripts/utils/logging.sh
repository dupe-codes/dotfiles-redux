# TODO: update these to optionally take a log file to write to
#       also consider switch to using gum log utility

print_ok() {
    GREEN_COLOR="\033[0;32m"
    DEFAULT="\033[0m"
    echo -e "${GREEN_COLOR} ✔ [OK]    [$(date '+%Y-%m-%d %H:%M:%S')]  ${1:-} ${DEFAULT}"
}

print_warning() {
    YELLOW_COLOR="\033[33m"
    DEFAULT="\033[0m"
    echo -e "${YELLOW_COLOR} ⚠ [WARN]  [$(date '+%Y-%m-%d %H:%M:%S')]  ${1:-} ${DEFAULT}"
}

print_info() {
    BLUE_COLOR="\033[0;34m"
    DEFAULT="\033[0m"
    echo -e "${BLUE_COLOR}  [INFO]  [$(date '+%Y-%m-%d %H:%M:%S')]  ${1:-} ${DEFAULT}"
}

print_fail() {
    RED_COLOR="\033[0;31m"
    DEFAULT="\033[0m"
    echo -e "${RED_COLOR}  [ERROR] [$(date '+%Y-%m-%d %H:%M:%S')]  ${1:-}${DEFAULT}"
}
