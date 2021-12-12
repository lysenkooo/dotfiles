export ZSH="/Users/ccbe/.oh-my-zsh"
ZSH_THEME="af-magic"
DISABLE_AUTO_UPDATE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export PATH="/opt/homebrew/opt/ansible@2.8/bin:$PATH"
export PATH="/opt/homebrew/opt/node@12/bin:$PATH"
# export PATH="/opt/homebrew/opt/postgresql@11/bin:$PATH"

export LDFLAGS="${LDFLAGS} -L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="${CPPFLAGS} -I/opt/homebrew/opt/libffi/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/opt/homebrew/opt/libffi/lib/pkgconfig"

export LDFLAGS="${LDFLAGS} -L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="${CPPFLAGS} -I/opt/homebrew/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"

# export LDFLAGS="${LDFLAGS} -L/opt/homebrew/opt/postgresql@11/lib"
# export CPPFLAGS="${CPPFLAGS} -I/opt/homebrew/opt/postgresql@11/include"
# export PKG_CONFIG_PATH="${PKG_CONFUG_PATH}:/opt/homebrew/opt/postgresql@11/lib/pkgconfig"

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/homebrew/opt/openssl@1.1"
export NODE_OPTIONS="--max_old_space_size=4096"

export HISTSIZE="9999"
export HISTFILESIZE="9999"
export HISTCONTROL="ignoredups"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
# export SUDO_PS1="\w\\$ "
export EDITOR="nvim"
export SVN_EDITOR="nvim"
export ANSIBLE_HOST_KEY_CHECKING="False"
#export OCI_DIR="$(brew --prefix)/lib"
export NLS_LANG="AMERICAN_AMERICA.UTF8"
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export DISABLE_AUTO_TITLE=true
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.private/gcloud.json
export SSLKEYLOGFILE=~/.ssl.log
export VAGRANT_DISABLE_VBOXSYMLINKCREATE=1
export DYLD_FORCE_FLAT_NAMESPACE="1"
#export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$DYLD_LIBRARY_PATH
export BASH_SILENCE_DEPRECATION_WARNING=1

# preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh

export NVM_DIR="$HOME/.nvm"
export NVM_AUTO_USE=true
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# if [ -f $HOME/.aliases ]; then
#     source $HOME/.aliases
# fi

alias la='ls -la'
alias grep='grep --color=auto'
alias vi='nvim'
alias vim='nvim'
alias dev_appserver.py='/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/dev_appserver.py'
alias myip='curl ifconfig.co/json'
alias chrome='open -a /Applications/Google\ Chrome.app'
alias ra='source ~/.aliases'
alias ltu='lt --subdomain crashcube --port 4000'
alias vsconf='vi "/Users/crashcube/Library/Application Support/Code/User/settings.json"'

# os x
alias ic='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias show='defaults write com.apple.finder AppleShowAllFiles true && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles false && killall Finder'
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias wallup='sudo pfctl -f /etc/pf.conf -e'
alias walldown='sudo pfctl -d'
alias fixttl='sudo sysctl -w net.inet.ip.ttl=65'
alias fwen='sudo pfctl -e -f /etc/pf.conf'
alias fwds='sudo pfctl -d'
alias sa='ssh-add'

# tmux
alias ts='tmux ls'
alias ta='tmux attach -t main || tmux new -s main'
alias tk='tmux kill-session -t'
alias tt='tmuxinator start'

# git
alias gc='git checkout'
alias gb='git branch'
alias ga='git add'
alias gi='git commit'
alias gs='git status'
alias gd='git diff'
alias gh='git log'
alias gm='git merge'
alias gl='git pull'
alias glr='git pull --rebase'
alias gp='git push'
alias gpo='git push -u origin HEAD'
alias ghr='hub pull-request'

gbf() {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf +s +m -e) &&
  git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
}

# git merge master
gmm() {
  if [ ! -z "$1" ]; then
    git checkout "$1"
  fi

  git fetch && git rebase
  git merge origin/master && git push
}

# git checkout and merge
#gcm() {
#  if [ -z "$1" ]; then
#    echo "Where to merge?"
#    return 1
#  fi
#
#  local branch
#  branch=$(git rev-parse --abbrev-ref HEAD)
#
#  git checkout "$1"
#  git fetch && git rebase
#  git merge $branch
#}

# dev
alias fs='foreman start'
alias om='overmind'
alias oms='overmind start'
alias omc='overmind connect'
alias omr='overmind restart'
alias be='bundle exec'
alias bsl='brew services list'
alias bsr='brew services run'
alias bss='brew services stop'
alias av='ansible-vault'
alias ave='ansible-vault encrypt --vault-id .vpass'
alias avd='ansible-vault decrypt --vault-id .vpass'
alias mtrr='mtr -s 1500 -r -n -c 1000 -i 0.1'
alias sl='subl -a .'
alias vs='code .'

# docker
alias docker='pgrep com.docker.hyperkit &> /dev/null || (open /Applications/Docker.app && until docker info &> /dev/null ; do sleep 1; done) && docker'
alias docker-compose='pgrep com.docker.hyperkit &> /dev/null || (open /Applications/Docker.app && until docker info &> /dev/null ; do sleep 1; done) && docker-compose'
alias sen='docker run --rm --name sen -it -v /var/run/docker.sock:/run/docker.sock -e TERM tomastomecek/sen'
alias dc='docker-compose'
alias dcr='docker-compose run --rm'
alias dcu='docker-compose up'
alias dcd='docker-compose down'

dstart() {
  if ! $(docker info > /dev/null 2>&1); then
    echo "Opening Docker for Mac..."
    open -a /Applications/Docker.app
    while ! docker system info > /dev/null 2>&1; do sleep 1; done
    echo "Docker is ready to rock!"
  else
    echo "Docker is up and running."
  fi
}

# misc
alias pgen8='pwgen -Cs 8 1 | tr -d " " | tr -d "\n" | pbcopy'
alias pgen15='pwgen -Cs 15 1 | tr -d " " | tr -d "\n" | pbcopy'
alias workhard='cat /etc/hosts | sed "/127.0.0.1 vk.com/s/^#//g" | sudo tee /etc/hosts'
alias procrastinate='cat /etc/hosts | sed "/127.0.0.1 vk.com/s/^/#/g" | sudo tee /etc/hosts'
alias compact720='ffmpeg -vf scale=-1:720 -crf 18 -preset ultrafast'

# functions

bh() {
  local command
  command=$(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
  echo $command
  eval $command
}

ovi() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  vi "$dir"
}

unmount() {
    if [ ! -d "$1" ]; then
        echo "Specify correct mount point"
        return 1
    fi

    rm -rf "$1/.fseventsd"
    rm -rf "$1/.Trashes"
    rm -rf "$1/.Spotlight-V100"
    find "$1" -name "._*" -exec rm {} \;
    find "$1" -name ".DS_Store" -exec rm {} \;

    diskutil unmount "$1"
}

gerge() {
    if [ -z $1 ]; then
        echo "Specify where to merge current branch"
        return 1
    fi

    BRANCH=$(git symbolic-ref --short HEAD)

    git checkout $1 && git pull --rebase && git merge $BRANCH && git push && git checkout ${BRANCH}
}

attrclean() {
    if [ -e $1 ]; then
        echo "Specify the path"
        return 1
    fi

    chmod -RN $1
    xattr -rc $1
}

csrgen() {
    if [ -z $1 ]; then
        echo "Specify FQDN"
        return 1
    fi

    openssl req -newkey rsa:2048 -sha256 -nodes -keyout "${1}.key" -out "${1}.csr"
    openssl x509 -req -days 365 -in "${1}.csr" -signkey "${1}.key" -out "${1}.crt"
}

lvhgen() {
    openssl req -newkey rsa:2048 -x509 -nodes -keyout lvh.me.key -sha256 -days 3650 -new -out lvh.me.crt -subj '/CN=*.lvh.me' -reqexts SAN -extensions SAN -config <(cat /System/Library/OpenSSL/openssl.cnf <(printf '[SAN]\nsubjectAltName=DNS:lvh.me,DNS:*.lvh.me'))
}

chmod_restore() {
    if [ -z $1 ]; then
        echo "Empty path"
        return 1
    fi

    find "$1" -type d -exec chmod 0755 {} \;
    find "$1" -type f -exec chmod 0644 {} \;
}

find_big() {
    find / -size +100M 2> /dev/null
}

encrypt() {
    if [ ! -f "$1" ]; then
      echo "File does not exist"
      return
    fi

    if [ -z "$2" ]; then
      echo "Specify path"
      return
    fi

    cat "$1" | openssl enc -aes-256-cbc -salt > "$2"
}

decrypt() {
    if [ ! -f "$1" ]; then
      echo "File does not exist"
      return
    fi

    openssl enc -aes-256-cbc -d -in "$1"
}

sshsu() {
    if [ -z $1 ]; then
        echo "Empty host"
        return 1
    fi

    if [ -z $2 ]; then
        echo "Empty username"
        return 1
    fi

    ssh "$1" sudo su "$2" -c "${@:3}"
}

sshscr() {
    if [ -z $1 ]; then
      echo "Specify FQDN"
      return 1
    fi

    ssh "$1" -t screen -R
}

sshmux() {
    if [ -z $1 ]; then
      echo "Specify FQDN"
      return 1
    fi

    ssh "$1" -t "tmux -CC attach || tmux -CC"
}

pg_reset() {
    if [ -z $1 ]; then
        echo "Missing database name"
        return 1
    fi

    psql postgres -c "DROP DATABASE $1"
    psql postgres -c "CREATE DATABASE $1"
}

remove_layout() {
    if [ -z $1 ]
    then
        echo "Empty pattern"
        return 1
    fi

    find . -type f -name '*.html' -o -name '*.html.erb' | while read file
    do
        echo $file
        sed -n "$1" "$file" | sed '1d' | sed '$d' > tmp
        mv -f tmp "$file"
    done
}

iconv_recursive() {
    find . -type f -name '*.html' -o -name '*.html.erb' | while read file
    do
        echo $file
        iconv -f CP1251 -t UTF-8 "$file" > tmp
        mv -f tmp "$file"
    done
}

pghero() {
    if [ -z $1 ]; then
        echo "Specify database name"
        return 1
    fi

    docker run --rm --name pghero -it -p 8080:8080 -e DATABASE_URL=postgres://dlysenko:postgres@docker.for.mac.localhost:5432/$1 ankane/pghero
}

gocode() {
    brew services run postgresql
    brew services run redis
    #brew services run nginx
    #brew services run memcached
}

nocode() {
    brew services stop postgresql
    brew services stop redis
    #brew services stop nginx
    #brew services stop memcached
}

decdump() {
    FILE="$1"

    if [ ! -f "$FILE" ]; then
        echo "Wrong file name"
        return 1
    fi

    openssl aes-256-cbc -d -base64 -in "$FILE" -pass "pass:$DB_SECRET" -md sha256 -out dump.tar
    rm -f "$FILE"
}

undump() {
    FILE="$1"

    if [ ! -f "$FILE" ]; then
        echo "Wrong file name"
        return 1
    fi

    DIR="$(date +%H%M%S_%d%m%Y)"
    mkdir "$DIR"

    tar -xf "$FILE" -C "$DIR" --strip-components=2
    rm -rf "$FILE"
}

runnvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
}

