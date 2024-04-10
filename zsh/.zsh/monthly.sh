#!/bin/bash

function month() {
  # Check if the directories expected exist. If not, create them.
  if [[ ! -d ~/monthly ]]; then
    mkdir -p ~/monthly
  fi

  cd ~/monthly

  current_month=$(date "+%Y-%m")
  month_file="$current_month.md"

  if [[ ! -f $month_file ]]; then
    touch $month_file
  fi

  echo "# " >>$month_file

  vim $month_file
}
