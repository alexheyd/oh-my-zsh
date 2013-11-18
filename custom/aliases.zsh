# Add yourself some shortcuts to projects you often work on
# Example:
#
# brainstormr=/Users/robbyrussell/Projects/development/planetargon/brainstormr
#

gpull(){
	repo=$1

	if [ -z "$1" ]; then
		repo='origin'
	fi

	git pull $repo $(current_branch)
}

gpush(){
	repo=$1

	if [ -z "$1" ]; then
		repo='origin'
	fi

	git pull $repo $(current_branch)
}

# fasd aliases
alias e="a -e subl"

# Edit ZSH Config
alias ealias="subl ~/.oh-my-zsh/custom/aliases.zsh"
alias ecfg="subl ~/.zshrc"

# Navigation
alias h="cd ~"
alias sf="cd ~/Sites/swordfish"
alias sfgk="cd ~/Sites/swordfish/js/lib/gaikai"
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Git
alias g="git"
alias gs="git status"
alias gl="git log"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias ga="git add"
alias gaa="git add . -A"
alias gpu="git pull upstream"
alias gpo="git pull origin"
alias gfu="git fetch upstream"
alias gfo="git fetch origin"
alias grmbr="git branch -D"
alias gbr="git co -b"


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
alias restart="sudo apachectl -e info -k restart"
alias ehosts="subl /etc/hosts"
alias evhosts="subl /private/etc/apache2/extra/httpd-vhosts.conf"
alias ehttpdconf="subl /etc/apache2/httpd.conf"

# System
alias rmdir="rm -rf"
alias o="open"
alias oo="open ."
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Terminal
alias clr="clear"

# Exports
export EDITOR="subl"