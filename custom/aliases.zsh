# Add yourself some shortcuts to projects you often work on
# Example:
#
# brainstormr=/Users/robbyrussell/Projects/development/planetargon/brainstormr
#

gpl(){
	repo=$1

	if [ -z "$1" ]; then
		repo="origin"
	fi

	git pull $repo $(current_branch)
}

gps(){
	repo=$1

	if [ -z "$1" ]; then
		repo="origin"
	fi

	git push $repo $(current_branch)
}

# creates git branch name based on gaikai format (features/gaikai.ah/develop/20140101/featureName)
gmybr(){
    if [ -z "$1" ]; then
        echo "Branch feature name required."
        return
    fi

    feature_name=$1
    prefix=$2
    suffix=$3
    date=$(date +%Y%m%d)

    if [ -z "$2" ]; then
        prefix="features"
    fi

    if [ -z "$3" ]; then
        suffix="develop"
    fi

    branch_name="$prefix/gaikai.ah/$suffix/$date/$feature_name"

    git checkout -b $branch_name
}

# fasd aliases
# alias e="a -e subl"

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

# Exports
export EDITOR="subl"