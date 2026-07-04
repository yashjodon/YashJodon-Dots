#!/usr/bin/env bash

# ==========================================================
# YashJodon-Dots
# colors.sh
#
# Terminal color helper library.
#
# This file intentionally exports NO global color variables.
# Colors are accessed through helper functions.
# ==========================================================

# Prevent multiple sourcing
[[ "${YJD_COLORS_LOADED:-0}" == "1" ]] && return 0
readonly YJD_COLORS_LOADED=1

# Return ANSI escape sequence
yjd_color() {
    case "$1" in
        reset)      printf '\033[0m' ;;
        black)      printf '\033[30m' ;;
        red)        printf '\033[31m' ;;
        green)      printf '\033[32m' ;;
        yellow)     printf '\033[33m' ;;
        blue)       printf '\033[34m' ;;
        magenta)    printf '\033[35m' ;;
        cyan)       printf '\033[36m' ;;
        white)      printf '\033[37m' ;;

        bright-black)   printf '\033[90m' ;;
        bright-red)     printf '\033[91m' ;;
        bright-green)   printf '\033[92m' ;;
        bright-yellow)  printf '\033[93m' ;;
        bright-blue)    printf '\033[94m' ;;
        bright-magenta) printf '\033[95m' ;;
        bright-cyan)    printf '\033[96m' ;;
        bright-white)   printf '\033[97m' ;;

        bold)       printf '\033[1m' ;;
        dim)        printf '\033[2m' ;;
        italic)     printf '\033[3m' ;;
        underline)  printf '\033[4m' ;;

        *)
            return 1
            ;;
    esac
}

# Print colored text
yjd_print_color() {

    local color="$1"
    shift

    printf "%b%s%b" \
        "$(yjd_color "$color")" \
        "$*" \
        "$(yjd_color reset)"
}

# End of File