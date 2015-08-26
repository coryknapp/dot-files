function pfd() {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}

function cdf() {
  cd "$(pfd)"
}



alias vt='mvim -c "vsplit test.cpp"'
alias v='mvim'
