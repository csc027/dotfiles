#!/bin/bash

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# load profile if it would not be run (i.e., when in a non-login shell)
if [ $(shopt login_shell | cut -f2) == 'off' ] && [ -f ~/.profile ]; then
	source ~/.profile
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "$(command -v oh-my-posh)" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi

	if [ -f ~/.git-prompt.bash ]; then
		source ~/.git-prompt.bash
		if [ "$color_prompt" == "yes" ]; then
			PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;36m\]$(git_bash_prompt)\[\033[00m\] \$ '
		else
			PS1='\u@\h:\w$(git_bash_prompt) \$ '
		fi
	elif [ "$color_prompt" == "yes" ]; then
		PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;36m\]\[\033[00m\] \$ '
	else
		PS1='\u@\h:\w \$ '
	fi
	unset color_prompt force_color_prompt
else
	# search for latest cached prompt
	if [ -f ~/.omp.sh ]; then
		source ~/.omp.sh
	else
		echo "No cached prompt found.  Please initialize oh-my-posh using 'oh-my-posh init bash --config ~/.prompt.json'."
	fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# git completion ignore case
GIT_COMPLETION_IGNORE_CASE=1
export GIT_COMPLETION_IGNORE_CASE

# git completion
if [ -f ~/.git-completion.bash ]; then
	source ~/.git-completion.bash
elif [ -f /etc/bash_completion.d/git ]; then
	source /etc/bash_completion.d/git
elif [ -f /usr/share/bash-completion/completions/git ]; then
	source /usr/share/bash-completion/completions/git
elif command -v pkg-config --variable=completionsdir bash-completion &> /dev/null && [ -f "$(pkg-config --variable=completionsdir bash-completion)"/git ]; then
	source "$(pkg-config --variable=completionsdir bash-completion)"/git
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		source /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		source /etc/bash_completion
	fi
fi

# Enable fzf shell integration; this must come after bash completion to work
if [ -f ~/.fzf.sh ]; then
	source ~/.fzf.sh
fi
# Set default fzf command if fd is detected
if ! [ -z "$(command -v fzf)" ] && ! [ -z "$(command -v fd)" ]; then
	export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git'
fi
