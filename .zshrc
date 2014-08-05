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
setopt extended_glob > /dev/null 2>&1
source $ZSH/oh-my-zsh.sh > /dev/null 2>&1
bindkey -s "^[e" "^qgit_prompt_info\n" > /dev/null 2>&1
set agnoster
#set +oglob
autoload -Uz promptinit > /dev/null 2>&1
promptinit > /dev/null 2>&1
prompt adam1 > /dev/null 2>&1
alias less!="vim -u NONE -R /var/log/vdsm/vdsm.log -S /root/log.vim '+set nonu' '+set wrap'"
alias less2="vim -u NONE -R /var/log/vdsm/vdsm.log -S /root/vdsm.vim '+set nonu' '+set wrap'"
# User specific aliases and functions
 alias vi="vim"
 alias monitor="/root/.monitor"
 alias yum="noglob yum"
# Customize to your needs...
OK=$(cat /root/vsyntax/Ok.txt)
CLASS=$(cat /root/vsyntax/class.txt)
FILE=$(cat /root/vsyntax/file.txt)
REG=$(cat /root/vsyntax/regular.txt)
ERR=$(cat /root/vsyntax/Err.txt)
FUNC=$(cat /root/vsyntax/_vdsmAPI.txt)
export OK
export CLASS
export REG
export ERR
export FUNC
export FILE
bind -r "\C-s" > /dev/null 2>&1
stty -ixon > /dev/null 2>&1

