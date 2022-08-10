export ZSH="/Users/ccbe/.oh-my-zsh"
ZSH_THEME="af-magic"
DISABLE_AUTO_UPDATE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh
PS1="${FG[032]}%~\$(git_prompt_info)\$(hg_prompt_info) ${FG[105]}%(!.#.»)%{$reset_color%} "
RPS1=""

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export HISTSIZE="9999"
export HISTFILESIZE="9999"
export HISTCONTROL="ignoredups"

export LDFLAGS="${LDFLAGS} -L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="${CPPFLAGS} -I/opt/homebrew/opt/libffi/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/opt/homebrew/opt/libffi/lib/pkgconfig"

export LDFLAGS="${LDFLAGS} -L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="${CPPFLAGS} -I/opt/homebrew/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"

#export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/homebrew/opt/openssl@1.1"

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
eval "$(/opt/homebrew/bin/brew shellenv)"
#export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
export NVM_AUTO_USE=true
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
#source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby 2.7.6
export PATH="bin:$PATH"

alias vi='nvim'
alias vim='nvim'
alias vis='vi ~/.ssh/config'
alias ip='curl ifconfig.co/json'
alias ze='vi ~/.zshrc'
alias zr='source ~/.zshrc'
alias la='ls -la'
alias sa='ssh-add'
alias ic='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias ttl='sudo sysctl -w net.inet.ip.ttl=65'
alias ltu='lt --subdomain crashcube --port 4000'
alias dns-flush='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias node-clean='find . -name node_modules -type d -prune -print -exec rm -rf {} \;'
alias fwen='sudo pfctl -e -f /etc/pf.conf'
alias fwds='sudo pfctl -d'
alias ts='tmux ls'
alias ta='tmux attach -t main || tmux new -s main'
alias tk='tmux kill-session -t'
alias gc='git checkout'
alias gb='git branch'
alias ga='git add'
alias gi='git commit'
alias giw='git commit -m WIP'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gh='git log'
alias gm='git merge'
alias gp='git push'
alias gpf='git push -f'
alias gpo='git push -u origin HEAD'
alias gl='git pull'
alias glr='git pull --rebase'
alias grc='git rebase --continue'
alias ghprm='gh pr create --base master'
alias ghprd='gh pr create --base develop'
alias rba='rubocop -a'
alias rbaa='rubocop -A'
alias pgen8='pwgen -Cs 8 1 | tr -d " " | tr -d "\n" | pbcopy'
alias pgen15='pwgen -Cs 15 1 | tr -d " " | tr -d "\n" | pbcopy'
alias workhard='cat /etc/hosts | sed "/127.0.0.1 vk.com/s/^#//g" | sudo tee /etc/hosts'
alias procrastinate='cat /etc/hosts | sed "/127.0.0.1 vk.com/s/^/#/g" | sudo tee /etc/hosts'
alias compact720='ffmpeg -vf scale=-1:720 -crf 18 -preset ultrafast'
alias fs='foreman start'
alias om='overmind'
alias oms='overmind start'
alias omc='overmind connect'
alias omr='overmind restart'
alias rspec='bin/rspec'
alias rails='bin/rails'
alias rake='bin/rake'
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
# alias docker='pgrep com.docker.hyperkit &> /dev/null || (open /Applications/Docker.app && until docker info &> /dev/null ; do sleep 1; done) && docker'
# alias docker-compose='pgrep com.docker.hyperkit &> /dev/null || (open /Applications/Docker.app && until docker info &> /dev/null ; do sleep 1; done) && docker-compose'
alias sen='docker run --rm --name sen -it -v /var/run/docker.sock:/run/docker.sock -e TERM tomastomecek/sen'
alias dc='docker-compose'
alias dcr='docker-compose run --rm'
alias dcu='docker-compose up'
alias dcd='docker-compose down'

gocode() {
    brew services run postgresql
    brew services run redis
}

nocode() {
    brew services stop postgresql
    brew services stop redis
}

runnvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
}

gbf() {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf +s +m -e) &&
  git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
}

gmm() {
  if [ ! -z "$1" ]; then
    git checkout "$1"
  fi

  git fetch && git rebase
  git merge origin/master && git push
}

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
