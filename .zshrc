#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
clear
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
plugins=(git)
ZSH_THEME="bira"
export ZSH=/root/oh-my-zsh
setopt extended_glob
source $ZSH/oh-my-zsh.sh
bindkey -s "^[e" "^qgit_prompt_info\n"
set agnoster
#set +oglob
autoload -Uz promptinit
promptinit
prompt adam1
alias less!="vim -u NONE -R /var/log/vdsm/vdsm.log -S /root/log.vim '+set nonu' '+set wrap'"
# User specific aliases and functions
 alias vi="vim"
 alias monitor="/root/.monitor"
 alias yum="noglob yum"
# Customize to your needs...
OK=$(cat /root/.msyntax/.Ok.txt)
CLASS=$(cat /root/.msyntax/.class.txt)
FILE=$(cat /root/.msyntax/.files.txt)
REG=$(cat /root/.msyntax/.regular.txt)
ERR=$(cat /root/.msyntax/.Err.txt)
FUNC=$(cat /root/.msyntax/._vdsmAPI.txt)
export OK
export CLASS
export REG
export ERR
export FUNC
bind -r "\C-s" > /dev/null 2>&1
stty -ixon > /dev/null 2>&1

