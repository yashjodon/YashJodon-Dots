#!/usr/bin/env bash

# ==========================================================
# YashJodon-Dots
# ui.sh
#
# Terminal UI helper library
# ==========================================================

[[ "${YJD_UI_LOADED:-0}" == "1" ]] && return 0
readonly YJD_UI_LOADED=1

# ----------------------------------------------------------
# Terminal Width
# ----------------------------------------------------------

yjd_terminal_width() {

    local width

    width=$(tput cols 2>/dev/null || echo 80)

    if [[ "$width" -lt 40 ]]; then
        width=80
    fi

    printf "%s" "$width"
}

# ----------------------------------------------------------
# Divider
# ----------------------------------------------------------

yjd_divider() {

    local width

    width=$(yjd_terminal_width)

    printf '%*s\n' "$width" '' | tr ' ' '='
}

# ----------------------------------------------------------
# Center Text
# ----------------------------------------------------------

yjd_center_text() {

    local text="$1"
    local width
    local padding

    width=$(yjd_terminal_width)

    padding=$(( (width - ${#text}) / 2 ))

    (( padding < 0 )) && padding=0

    printf "%*s%s\n" "$padding" "" "$text"
}

# ----------------------------------------------------------
# Header
# ----------------------------------------------------------

yjd_header() {

    clear

    yjd_divider

    printf "\n"

    yjd_print_color bright-cyan ""
    yjd_center_text "YashJodon-Dots"
    printf "%b" "$(yjd_color reset)"

    yjd_print_color bright-white ""
    yjd_center_text "Version 0.1.0"
    printf "%b" "$(yjd_color reset)"

    printf "\n"

    yjd_divider

    printf "\n"
}

# ----------------------------------------------------------
# Section
# ----------------------------------------------------------

yjd_section() {

    local title="$1"

    printf "\n"

    yjd_divider

    yjd_print_color bright-blue ""
    yjd_center_text "$title"
    printf "%b" "$(yjd_color reset)"

    yjd_divider

    printf "\n"
}

# ----------------------------------------------------------
# Blank Line
# ----------------------------------------------------------

yjd_newline() {
    printf "\n"
}

# ----------------------------------------------------------
# Pause
# ----------------------------------------------------------

yjd_pause() {
    read -r -p "Press Enter to continue..."
}

# ----------------------------------------------------------
# Confirmation
# ----------------------------------------------------------

yjd_confirm() {

    local prompt="$1"
    local answer

    read -r -p "${prompt} [y/N]: " answer

    case "$answer" in
        [Yy]|[Yy][Ee][Ss])
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}