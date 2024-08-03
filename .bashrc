#!/usr/bin/env bash

# If not running interactively, stop and exit
[[ $- != *i* ]] && return

# Add completion for commands
complete -cf sudo

# Set shell options
## cd if only a path is typed
shopt -s autocd

# reset COLUMNS and LINES after every command
## keep terminal displayed well
shopt -s checkwinsize

# Set prompt string
PS1='[\u@\h \W]\$ '

# Simple aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias sudo='sudo -v; sudo '
alias diff='diff --color=auto'

# Alias for whipper
type whipper > /dev/null 2>&1
if [[ "$?" -eq 0 ]]; then
    alias arip='whipper cd rip --unknown'
fi

# Alias for dots 
type git > /dev/null 2>&1
if [[ "$?" -eq 0 ]]; then
    alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    source /usr/share/bash-completion/completions/git
    __git_complete dots __git_main
fi

# Suggest packages for unknown commands
type pkgfile > /dev/null 2>&1
if [[ "$?" -eq 0 ]]; then
    source /usr/share/doc/pkgfile/command-not-found.bash
    pkgfile --update > /dev/null 2>&1
fi

# Load .Xresources
type xrdb > /dev/null 2>&1
if [[ -f "${HOME}/.Xresources" ]]; then
    xrdb -merge "${HOME}/.Xresources"
fi
