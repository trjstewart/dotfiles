function clock() {
  local -A people
  names=(
    'David Buchan-Swanson'
    'Alex Ghiculescu'
    'Bryce Davies'
  )
  gh_avatar_ids=(
    '4755785'
    '509837'
    '-1'
  )
  time_zones=(
    'Australia/Brisbane'
    'America/Los_Angeles'
    'Europe/London'
  )

  for (( i = 1; i <= $#names; i++ )); do
    id=$gh_avatar_ids[$i]
    if [[ $id = "-1" ]]; then
      echo "NO IMAGE"
    else
      imgcat -u $(gh_avatar_url $id)
    fi
    echo "${names[$i]}"
    echo "Time: $(TZ=${time_zones[$i]} date)"
    echo "" # newline
  done
}


