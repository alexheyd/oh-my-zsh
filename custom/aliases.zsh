# Add yourself some shortcuts to projects you often work on
# Example:
#
# brainstormr=/Users/robbyrussell/Projects/development/planetargon/brainstormr
#

# Exports
export EDITOR="subl"

# (Gaikai Specific) open Google Chrome with Web Security Disabled
alias chr="open /Applications/Google\ Chrome.app --args --disable-web-security"
alias canary="open /Applications/Google\ Chrome\ Canary.app --args --disable-web-security"
alias swfstatic="static --cache 1 --port 9999"
alias undodebug="grt && git co js/app/AppConfig.js && g co js/app/Components/TLX/details.xml"

# Global Aliases
alias -g L="|less" # Write L after a command to page through the output.
alias -g TL='| tail -20'

# Edit ZSH Config
alias ealias="subl ~/.oh-my-zsh/custom/aliases.zsh"
alias ecfg="subl ~/.zshrc"

# Navigation
alias h="cd ~"
alias sf="cd ~/Sites/swordfish"
alias sfgk="cd ~/Sites/swordfish/js/lib/gaikai"
alias gk="cd ~/Sites/gaikai.com"
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Git
alias g="git"
alias gs="git status -sb"
alias gss="git status -s"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias ga="git add"
alias gaa="git add . -A"
alias gfu="git fetch upstream"
alias gfo="git fetch origin"
alias grmbr="git branch -D"
alias gbr="git co -b"
alias cbr="current_branch"
alias unstage="git reset"
alias undoall="git reset --hard"
alias rollback="git reset --soft 'HEAD^'"
alias gst="git stash"
alias gstc="git stash clear"
alias gsta="git stash apply"
alias undopush="git push -f origin HEAD^:master"
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`' # git root


# Dotfiles
alias src="source ~/.zshrc"
# alias src="source ~/.bash_profile"
# alias ealiases="subl ~/.aliases"
# alias eextras="subl ~/.extra"
# alias erc="subl ~/.bashrc"
# alias eexports="subl ~/.exports"
# alias efunctions="subl ~/.functions"
# alias eprompt="subl ~/.bash_prompt"

# Apache
alias restart_apache="sudo apachectl -e info -k restart"
alias start_apache="sudo apachectl start"
alias stop_apache="sudo apachectl stop"
alias ehosts="subl /etc/hosts"
alias evhosts="subl /private/etc/apache2/extra/httpd-vhosts.conf"
alias eapache="subl /etc/apache2/httpd.conf"

# System
alias rmdir="rm -rf"
alias o="open"
alias oo="open ."
alias etrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Terminal
alias clr="clear"

# `cat` with beautiful colors. requires Pygments installed.
#                              sudo easy_install Pygments
alias c="pygmentize -O style=twilight -f console256 -g"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# Trim new lines and copy to clipboard
alias trimcopy="tr -d '\n' | pbcopy"

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# File size
alias fs="stat -f \"%z bytes\""

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"


# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="lwp-request -m '$method'"
done