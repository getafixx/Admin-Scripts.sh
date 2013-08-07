# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias whome='cd /var/www/vhosts/jxt.com.au/'
alias ct_dir='cd /var/spool/cron/'
#Reload Bashrc
alias reload='source ~/.bashrc'
shopt -s histverify
alias aplog='cd /usr/local/apache/logs'
#Save history correctly when using multiple terminals
# Dont save duplicate lines or blank lines in to history
export HISTCONTROL=ignoreboth
export HISTSIZE=1000
#Append changes to history instead of overwrite full file
alias exit='history -a && exit'

#An alternative to the line above is

# make it append, rather than overwrite the history
shopt -s histappend


# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi



# User specific aliases and functions

alias l='ls -la --color=auto'
alias ls='ls --color=auto'
alias ll='ls -lrt --color=auto'
alias grep='grep --color=auto'
alias dg='./dg.sh'

alias ct_dir='cd /var/spool/cron/'
#Reload Bashrc
alias reload='source ~/.bashrc'
shopt -s histverify

#Save history correctly when using multiple terminals
# Dont save duplicate lines or blank lines in to history
export HISTCONTROL=ignoreboth
export HISTSIZE=1000
#Append changes to history instead of overwrite full file
alias exit='history -a && exit'

#An alternative to the line above is

# make it append, rather than overwrite the history
shopt -s histappend


# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

shopt -s cdable_vars      # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell          # autocorrects cd misspellings
shopt -s checkwinsize     # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist          # save multi-line commands in history as single line
shopt -s dotglob          # include dotfiles in pathname expansion
shopt -s expand_aliases   # expand aliases
shopt -s extglob          # enable extended pattern-matching features
shopt -s histappend       # append to (not overwrite) the history file
shopt -s hostcomplete     # attempt hostname expansion when @ is at the beginning ofa word
shopt -s nocaseglob       # pathname expansion will be treated as case-insensitive

PS1='[\[\e[31m\]\u\[\e[35m\]@\[\e[39m\]\h\[\e[0m\]:\[\e[33m\]\w\[\e[0m\]] \$ '



