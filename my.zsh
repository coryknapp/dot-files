if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    #not sure why, but my custom omp doesn't work on MacOs
    eval "$(oh-my-posh init zsh --config ~/Code/dot-files/hotstick.ck.omp.json )"
fi

#fix where LaTeX is broken on macOS
export PATH="/usr/texbin":$PATH
export PATH="/Library/Frameworks/Mono.framework/Versions/Current/bin":${PATH}
export PATH="~/Code/dot-files/scripts":${PATH}

#return the path of the top finder window
function pfd() {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}

#return title of the foremost MacVim window 
function topMacVimTitle() {
    osascript 2>/dev/null <<EOF
    tell application "MacVim"
        return name of window 1
        end tell
EOF
}

#set the working dir to the top finder window
function cdf() {
  cd "$(pfd)"
}

#set the working dir to the top MacVim
function cdv() {
	#get the title of the macvim window
	#match the stuff between the parentheses
	#strip the (, then strip the )
	local dir="$(echo $(topMacVimTitle) | grep -o "(.*)" | sed 's/(//' | sed 's/)//')"
	dir="${dir/#\~/$HOME}" #expand the ~
	cd $dir
}

alias vsc='open -a "Visual Studio Code.app" .'

# && and this on to a command to get a noti when it's done.
alias noti="osascript -e 'display notification \"Shell task complete\"'"

#open two files with a vertical split in MacVim
function vvs() {
	local cmd="mvim -c \"vsplit $2\" $1"
	eval ${cmd}
}

alias v='mvim'
alias vt='v -c "vsplit test.cpp"'

#strip anything from the clipboard other then plain text
alias st='pbpaste | pbcopy'

#open vim with a Session file
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
		cd $cwd
 	fi
}

#open the current folder in the finder
alias f='open .'
alias co='cd ~/Code'

#open this file
alias mzsh='v ~/Code/dot-files/my.zsh'

alias gp='git push'
alias gs='git status'
alias gc='git commit -m'

alias add='git add'

alias p='python'
alias py='python'

# push my dot-file commits
alias dp='cd ~/Code/dot-files; git push; cd -'

# install my pre-commit in the .git dir
alias install-pre-commit='cp  ~/Code/dot-files/pre-commit .git/hooks/pre-commit'

#make a directory and move there
function mkcd {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

#change directory and list it
function c {
  if [ ! -n "$1" ]; then
	cd ~ && ls	
  else
    cd $1 && ls
  fi
}

#colorize man
function man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}
