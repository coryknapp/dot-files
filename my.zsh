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

function vvs() {
	local cmd="mvim -c \"vsplit $2\" $1"
	eval ${cmd}
}

alias v='mvim'
alias vt='v -c "vsplit test.cpp"'
alias vs='v -S'

function vsf(){
# open the Session.vim in the foremost finder window
	local cwd=$(pfd)
	if [ -f $cwd"/Session.vim" ];
	then
		vs $cwd"/Session.vim"
	else
		echo "Sorry.  No Session file in $cwd."
		echo "I'll move you there and you can do what you do, brother."
 	fi
}

#open the current folder in the finder
alias f='open .'
alias co='cd ~/Code'

alias j='java'
alias jc='javac'
alias jd='javadoc -d docs'

alias eclim='/Applications/Eclipse.app/Contents/Eclipse/eclimd'

alias usb='system_profiler SPUSBDataType'

alias gp='git push'
alias gs='git status'
alias gc='git commit -m'

alias p='python'
alias py='python'

function mkcd {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

alias tex='/Library/TeX/texbin/pdflatex'
