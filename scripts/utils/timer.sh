#!/usr/bin/env bash

# ==========================================================
# YashJodon-Dots
# timer.sh
#
# Timer helper library
# ==========================================================

[[ "${YJD_TIMER_LOADED:-0}" == "1" ]] && return 0
readonly YJD_TIMER_LOADED=1

# Timer state
YJD_TIMER_START=0

# ----------------------------------------------------------
# Start Timer
# ----------------------------------------------------------

yjd_timer_start() {

    YJD_TIMER_START=$(date +%s)

}

# ----------------------------------------------------------
# Elapsed Seconds
# ----------------------------------------------------------

yjd_timer_elapsed() {

    local now

    now=$(date +%s)

    printf "%d" "$(( now - YJD_TIMER_START ))"

}

# ----------------------------------------------------------
# Pretty Format
# ----------------------------------------------------------

yjd_timer_pretty() {

    local elapsed
    local minutes
    local seconds

    elapsed=$(yjd_timer_elapsed)

    minutes=$(( elapsed / 60 ))
    seconds=$(( elapsed % 60 ))

    printf "%02dm %02ds" "$minutes" "$seconds"

}