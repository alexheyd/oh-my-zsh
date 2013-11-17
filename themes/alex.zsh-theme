# alex.zsh-theme
#
# Author: Alex Heyd
#
# Created on:		Nov 5, 2013
# Last modified on:	Nov 5, 2013



if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'
eval my_red='%{$fg[red]%}'
eval my_yellow='%{$fg[yellow]%}'
eval my_blue='$FG[032]'
eval myhost='$(hostname -f)'

# primary prompt
PROMPT='$my_gray=======================================================================================%{$reset_color%}
$my_gray%n@$myhost%{$reset_color%} \
$my_blue%~ \

$FG[105]%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'

# right prompt
RPROMPT='$(git_prompt_info)'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$my_blue(branch:$my_yellow"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_red*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$my_blue)%{$reset_color%}"
