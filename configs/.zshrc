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
#eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
#[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
#source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby 2.7.6
export PATH="bin:$PATH"

alias o='open .'
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
alias ltu='lt --subdomain ccbe --port 4000'
alias dflsh='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias fwe='sudo pfctl -e -f /etc/pf.conf'
alias fwd='sudo pfctl -d'
alias ts='tmux attach -t main || tmux new -s main'
alias tl='tmux ls'
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
alias gma='git merge --abort'
alias gp='git push'
alias gpf='git push -f'
alias gpo='git push -u origin HEAD'
alias gpof='git push -u origin HEAD -f'
alias gl='git pull'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias glr='git pull --rebase'
alias ghprm='gh pr create --base master'
alias ghprd='gh pr create --base develop'
alias rba='rubocop -a'
alias rbaa='rubocop -A'
alias om='overmind'
alias oms='overmind start'
alias omc='overmind connect'
alias omr='overmind restart'
alias be='bundle exec'
alias bsl='brew services list'
alias bsr='brew services run'
alias bss='brew services stop'
alias av='ansible-vault'
alias ave='ansible-vault encrypt'
alias avd='ansible-vault decrypt'
alias mtrr='mtr -s 1500 -r -n -c 1000 -i 0.1'
alias vs='code .'
alias sl='subl -a .'
alias pwg='pwgen -Cs 15 1 | tr -d " " | tr -d "\n" | pbcopy'
alias ff720='ffmpeg -vf scale=-1:720 -crf 18 -preset ultrafast'
alias dc='docker-compose'
alias dcr='docker-compose run --rm'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias spg='sort-package-json'
alias sen='docker run --rm --name sen -it -v /var/run/docker.sock:/run/docker.sock -e TERM tomastomecek/sen'
alias docker='pgrep com.docker.hyperkit &> /dev/null || (open /Applications/Docker.app && until docker info &> /dev/null; do sleep 1; done) && docker'
alias docker-compose='pgrep com.docker.hyperkit &> /dev/null || (open /Applications/Docker.app && until docker info &> /dev/null ; do sleep 1; done) && docker-compose'
alias rgc='rake git:checkout'
alias ta='terraform apply'

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
}

nocode() {
    brew services stop postgresql
    brew services stop redis
}

unalias gg
gg() {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf +s +m -e) &&
  git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
}

gmt() {
  if [ -z "$1" ]; then
    echo "Where to merge?"
    return 1
  fi

  local branch
  branch=$(git rev-parse --abbrev-ref HEAD)

  git checkout "$1"
  git pull --rebase
  git merge --no-ff $branch
}

bh() {
  local command
  command=$(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
  echo $command
  eval $command
}

ovi() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
  vi "$dir"
}

modrest() {
    if [ -z $1 ]; then
        echo "Empty path"
        return 1
    fi

    find "$1" -type d -exec chmod 0755 {} \;
    find "$1" -type f -exec chmod 0644 {} \;
}

attrcln() {
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

ssc() {
    if [ -z $1 ]; then
      echo "Specify FQDN"
      return 1
    fi

    ssh "$1" -t screen -R
}

sst() {
    if [ -z $1 ]; then
      echo "Specify FQDN"
      return 1
    fi

    ssh "$1" -t "tmux -CC attach || tmux -CC"
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

iconvr() {
    find . -type f -name '*.html' -o -name '*.html.erb' | while read file
    do
        echo $file
        iconv -f CP1251 -t UTF-8 "$file" > tmp
        mv -f tmp "$file"
    done
}

big() {
    find / -size +100M 2> /dev/null
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
