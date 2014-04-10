# alexgit.zsh
# Creates a remote git repository from the current local directory

# Configuration
# Replace SSH_USERNAME, SSH_HOST, SSH_GIT_PATH with your details
USER=nycreal
HOST=alexheyd.com
GIT_PATH=/home/nycreal/git

REPO=${PWD##*/}
GIT_REMOTE_URL=ssh://$USER@$HOST/$GIT_PATH/$REPO

# Creates new git repo on personal Dreamhost server
alexgitnew() {
	echo "--------------------------------------------------"
	echo "------ Creating New Remote Git Repository --------"
	echo "--------------------------------------------------"

	# Setup remote repo

	echo "--"
	echo "-- Creating bare remote repo at:"
	echo "-- $USER@$HOST/$GIT_PATH/$REPO"
	echo "--"

	ssh $USER@$HOST 'mkdir '$GIT_PATH'/'$REPO' && cd '$GIT_PATH'/'$REPO' && git --bare init && git --bare update-server-info && cp hooks/post-update.sample hooks/post-update && chmod a+x hooks/post-update && touch git-daemon-export-ok'	

	echo "-------------------------------------------------"
	echo "------ Creating New Local Git Repository --------"
	echo "-------------------------------------------------"

	# Configure local repo

	echo "--"
	echo "-- Initializing local repo & pushing to remote"
	echo "--"

	touch .gitignore
	git init
	git add .
	git commit -m 'initial commit'
	git push --all $GIT_REMOTE_URL
	git remote add origin $GIT_REMOTE_URL
	git config branch.master.remote origin
	git config branch.master.merge refs/heads/master
	git fetch
	git merge master
	git branch -a

	echo "--"
	echo "-- Your new git repo '$REPO' is ready and initialized at:"
	echo "-- $USER@$HOST/$GIT_PATH/$REPO"
	echo "--"
}

# Add local git repo to personal Dreamhost server
alexgitadd() {

	echo "--------------------------------------------------"
	echo "------ Creating New Remote Git Repository --------"
	echo "--------------------------------------------------"

	# Setup remote repo

	echo "--"
	echo "-- Creating bare remote repo at:"
	echo "-- $USER@$HOST/$GIT_PATH/$REPO"
	echo "--"

	ssh $USER@$HOST 'mkdir '$GIT_PATH'/'$REPO' && cd '$GIT_PATH'/'$REPO' && git --bare init && git --bare update-server-info && cp hooks/post-update.sample hooks/post-update && chmod a+x hooks/post-update && touch git-daemon-export-ok'	

	git remote add alex $GIT_REMOTE_URL

	git add .
	git commit -m 'initial commit'
	git push --all $GIT_REMOTE_URL
}

# Shorthand to update current branch
# Usage (remote is optional):
# gpl upstream
# -> git pull upstream $(current_branch)
gpl(){
    repo=$1

    if [ -z "$1" ]; then
        repo="origin"
    fi

    git pull $repo $(current_branch)
}

# Shorthand to push current branch
# Usage (remote is optional):
# gps upstream
# -> git push upstream $(current_branch)
gps(){
    repo=$1

    if [ -z "$1" ]; then
        repo="origin"
    fi

    git push $repo $(current_branch)
}

# Shorthand to create new branch names based on a certain format
# Usage (prefix and suffix are optional):
# gmybr myFeatureName
# -> git checkout -b features/gaikai.ah/develop/$(date)/myFeatureName
# 
# gmybr myFeatureName hotfix testing
# -> git checkout -b hotfix/gaikai.ah/testing/$(date)/myFeatureName
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

# Create a new directory and enter it
function mdir() {
    mkdir -p "$1" && cd "$1"
}


# find shorthand
function f() {
    find . -name "$1"
}

# cd into whatever is the forefront Finder window.
cdf() {  # short for cdfinder
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}


# Copy w/ progress
cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}


# Test if HTTP compression (RFC 2616 + SDCH) is enabled for a given URL.
# Send a fake UA string for sites that sniff it instead of using the Accept-Encoding header. (Looking at you, ajax.googleapis.com!)
function httpcompression() {
    encoding="$(curl -LIs -H 'User-Agent: Mozilla/5 Gecko' -H 'Accept-Encoding: gzip,deflate,compress,sdch' "$1" | grep '^Content-Encoding:')" && echo "$1 is encoded using ${encoding#* }" || echo "$1 is not using any encoding"
}

# Syntax-highlight JSON strings or files
function json() {
    if [ -p /dev/stdin ]; then
        # piping, e.g. `echo '{"foo":42}' | json`
        python -mjson.tool | pygmentize -l javascript
    else
        # e.g. `json '{"foo":42}'`
        python -mjson.tool <<< "$*" | pygmentize -l javascript
    fi
}


# take this repo and copy it to somewhere else minus the .git stuff.
function gitexport(){
    mkdir -p "$1"
    git archive master | tar -x -C "$1"
}



# get gzipped size
function gz() {
    echo "orig size    (bytes): "
    cat "$1" | wc -c
    echo "gzipped size (bytes): "
    gzip -c "$1" | wc -c
}

# All the dig info
function digga() {
    dig +nocmd "$1" any +multiline +noall +answer
}

# Escape UTF-8 characters into their 3-byte format
function escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    echo # newline
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
    echo # newline
}

# Extract archives - use: extract <file>
# Based on http://dotfiles.org/~pseup/.bashrc
function extract() {
    if [ -f "$1" ] ; then
        local filename=$(basename "$1")
        local foldername="${filename%%.*}"
        local fullpath=`perl -e 'use Cwd "abs_path";print abs_path(shift)' "$1"`
        local didfolderexist=false
        if [ -d "$foldername" ]; then
            didfolderexist=true
            read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
            echo
            if [[ $REPLY =~ ^[Nn]$ ]]; then
                return
            fi
        fi
        mkdir -p "$foldername" && cd "$foldername"
        case $1 in
            *.tar.bz2) tar xjf "$fullpath" ;;
            *.tar.gz) tar xzf "$fullpath" ;;
            *.tar.xz) tar Jxvf "$fullpath" ;;
            *.tar.Z) tar xzf "$fullpath" ;;
            *.tar) tar xf "$fullpath" ;;
            *.taz) tar xzf "$fullpath" ;;
            *.tb2) tar xjf "$fullpath" ;;
            *.tbz) tar xjf "$fullpath" ;;
            *.tbz2) tar xjf "$fullpath" ;;
            *.tgz) tar xzf "$fullpath" ;;
            *.txz) tar Jxvf "$fullpath" ;;
            *.zip) unzip "$fullpath" ;;
            *) echo "'$1' cannot be extracted via extract()" && cd .. && ! $didfolderexist && rm -r "$foldername" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


# animated gifs from any video
# from alex sexton   gist.github.com/SlexAxton/4989674
gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}
