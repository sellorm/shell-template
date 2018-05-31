#!/usr/bin/env bash

# taken from here - https://dev.to/thiht/shell-scripts-matter
# And extended with info from here - http://redsymbol.net/articles/unofficial-bash-strict-mode/

# ----

set -euo pipefail
IFS=$'\n\t'

# set -e
#   exits on error
# set -u
#   exits on undefined variables
# set -x
#   echo's everything to stdout - v useful for debugging
# set -o pipeline
#   does not mask pipeline errors
# set -o noclobber
#   prevents overwriting of existing files

# Changing the IFS means you can properly parse line-by-line input, even if it includes spaces

# ----

# use shellcheck - https://www.shellcheck.net/

# use shUnit2 - https://github.com/kward/shunit2

# use bash debugger - http://bashdb.sourceforge.net/bashdb.html

# ----

# defaults for variables
# this is essential for positional parameters with set -u
my_arg=${1:-"default"}

# ----

# do some cleanup
cleanup() {
    # ...
}
trap cleanup EXIT

# ----

# do some logging
readonly LOG_FILE="/tmp/$(basename "$0").log"
info()    { echo "$(date +%FT%T%z) [INFO]    $@" | tee -a "$LOG_FILE" >&2 ; }
warn()    { echo "$(date +%FT%T%z) [WARN]    $@" | tee -a "$LOG_FILE" >&2 ; }
error()   { echo "$(date +%FT%T%z) [ERROR]   $@" | tee -a "$LOG_FILE" >&2 ; }
fatal()   { echo "$(date +%FT%T%z) [FATAL]   $@" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }

# ----

# document your scripts
#/ Usage: add <first number> <second number>
#/ Compute the sum of two numbers
usage() {
    grep '^#/' "$0" | cut -c4-
    exit 0
}
expr "$*" : ".*--help" > /dev/null && usage

# uses lines starting #/ as the documentation

# ----

# check if script is sourced or being run directly
if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    trap cleanup EXIT
    # Script goes here
    # ...
fi

