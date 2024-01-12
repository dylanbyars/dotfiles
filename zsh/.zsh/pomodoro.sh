#!/bin/zsh

# TODO:
# - reset the terminal title when quit even if it's a hard kill
# - add a function to quit the pomodoro when `q` is pressed
# - add a function to pause the pomodoro when `space` is pressed
# - show the cycle number in the terminal output

# Default durations in minutes
WORK_DURATION=${1:-25}
SHORT_BREAK_DURATION=${2:-5}
LONG_BREAK_DURATION=${3:-15}
LONG_BREAK_AFTER=${4:-4}
SOUND_FILE="/System/Library/Sounds/Blow.aiff"

# Global variables for time and session emoji
CURRENT_TIME=""
INTERVAL_EMOJI=""

# Function to set the Kitty terminal title
set_kitty_title() {
  echo -ne "\033]0;${INTERVAL_EMOJI} ${CURRENT_TIME}\007"
}

# Function to display the countdown
countdown() {
  local secs=$(( $1 * 60 ))

  while [ $secs -gt 0 ]; do
    CURRENT_TIME=$(date -u -r $secs +%M:%S)
    echo -ne "\r${CURRENT_TIME}"
    set_kitty_title
    sleep 1
    ((secs--))
  done
  CURRENT_TIME="00:00"
  echo -ne "\r${CURRENT_TIME}\n"
  set_kitty_title

  for i in {1..3}; do
    afplay $SOUND_FILE
  done
}

# Main Pomodoro function
pomodoro() {
  local cycles=0
  while true; do
    echo "Work for $WORK_DURATION minutes."
    INTERVAL_EMOJI="🛠"  # Work session with hammer emoji
    countdown $WORK_DURATION

    ((cycles++))
    if ((cycles % LONG_BREAK_AFTER == 0)); then
      echo "Long break for $LONG_BREAK_DURATION minutes."
      INTERVAL_EMOJI="🍵"  # Long break session with tea emoji
      countdown $LONG_BREAK_DURATION
    else
      echo "Short break for $SHORT_BREAK_DURATION minutes."
      SESSION_ENOJI="🌴"  # Short break session with palm tree emoji
      countdown $SHORT_BREAK_DURATION
    fi
  done
}

