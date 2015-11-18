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
#get the title of the macvim window
#match the stuff between the parentheses
#strip the (, then strip the )
local dir="$(echo $(topMacVimTitle) | grep -o "(.*)" | sed 's/(//' | sed 's/)//')"
dir="${dir/#\~/$HOME}" #expand the ~
cd $dir
}

function vs() {
	local cmd="mvim -c \"vsplit $2\" $1"
	eval ${cmd}
}

#open the current folder in the finder
alias o='open .'
alias co='cd ~/Code'

alias vt='mvim -c "vsplit test.cpp"'
alias v='mvim'

alias j='java'
alias jc='javac'
alias jd='javadoc -d docs'

alias eclim='/Applications/Eclipse.app/Contents/Eclipse/eclimd'

alias usb='system_profiler SPUSBDataType'

alias gp='git push'
alias gs='git status'
alias gc='git commit -m'
