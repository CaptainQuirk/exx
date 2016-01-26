if [[ ! -o interactive ]]; then
    return
fi

compctl -K _exx exx

_exx() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(exx commands)"
  else
    completions="$(exx completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}
