export PATH="/usr/texbin":$PATH

function pfd() {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}

function topMacVimTitle() {
  osascript 2>/dev/null <<EOF
tell application "MacVim"
	return name of window 1
end tell
EOF
}

function cdf() {
  cd "$(pfd)"
}

function cdv() {
local dir="$(echo $(topMacVimTitle) | grep -o "(.*)" | sed 's/(//' | sed 's/)//')"
dir="${dir/#\~/$HOME}" #expand the ~
cd $dir
}

alias vt='mvim -c "vsplit test.cpp"'
alias v='mvim'

alias j='java'
alias jc = 'javac'
alias jd='javadoc -d docs'
