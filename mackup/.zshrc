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

export PATH="$HOME/.bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
#eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
#export PATH="$HOME/.pyenv/shims:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
#[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
#chruby 2.7.7

export PATH="bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# development
alias vs='code .'
alias sl='subl -a .'
alias ms='make s'
alias om='overmind'
alias oms='overmind start'
alias omc='overmind connect'
alias omr='overmind restart'
alias bsl='brew services list'
alias bsr='brew services run'
alias bss='brew services stop'
alias ltu='lt --subdomain ccbe --port 4000'

gocode() {
    brew services run postgresql@14
    brew services run redis
}

nocode() {
    brew services stop postgresql@14
    brew services stop redis
}

pghero() {
    if [ -z $1 ]; then
        echo "Specify database name"
        return 1
    fi

    docker run --rm --name pghero -it -p 8080:8080 -e DATABASE_URL=postgres://dlysenko:postgres@docker.for.mac.localhost:5432/$1 ankane/pghero
}

ovi() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
  vi "$dir"
}

rtf() {
  local i=0

  while true; do
    ((i=i+1))
    echo "Attempt $i"

    $@

    if [[ "$?" -ne 0 ]]; then
      break
    fi

    sleep 1
  done
}

# tmux
alias ts='tmux attach -t main || tmux new -s main'
alias tl='tmux ls'
alias tk='tmux kill-session -t'

# git
alias gc='git checkout'
alias gco='git checkout --ours'
alias gct='git checkout --theirs'
alias gb='git branch'
alias gbd='git branch -d'
alias gbdd='git branch -D'
alias ga='git add'
alias gi='git commit'
alias gia='git commit --amend -n'
alias giw='git commit -a -m WIP'
alias giwp='git commit -a -m WIP && git push'
alias grs='git reset'
alias gs='git status'
alias gd='git diff'
alias gd1='git diff HEAD~1'
alias gds='git diff --staged'
alias glo='git log --numstat'
alias gm='git merge'
alias gma='git merge --abort'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gcp='git cherry-pick'
alias grm='git fetch && git rebase origin/main'
alias grd='git fetch && git rebase origin/develop'
alias gmm='git fetch && git rebase && git merge --ff origin/main'
alias gmd='git fetch && git rebase && git merge --ff origin/develop'
alias gfp='git fetch --prune'
alias gl='git pull'
alias glr='git pull --rebase'
alias gp='git push'
alias gpf='git push -f'
alias gpo='git push -u origin HEAD'
alias gpof='git push -u origin HEAD -f'
alias ghprv='gh pr view --web'
alias ghpr='gh pr create'
alias ghprm='gh pr create -B main -F .github/PULL_REQUEST_TEMPLATE.md'
alias ghprd='gh pr create -B develop -F .github/PULL_REQUEST_TEMPLATE.md'
alias gbcln='git branch | grep -vE " (master|main|develop)" | xargs git branch -d'

gim() {
    if [ -z "$*" ]; then
        echo "Specify commit message"
        return 1
    fi

    git commit -m "$*"
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

unalias gg
gg() {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf +s +m -e) &&
  git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
}

git-fetch-all() {
  local root=$(pwd)

  for f in *; do
    local p="$root/$f"

    if [ -d "$p" ]; then
      echo "------------------------------------------------------------"
      echo "$p"
      cd "$p"
      git fetch --all --prune
      git pull --all || true
    fi
  done

  cd "$root"
}

owners(){
  for f in $(git ls-files); do
    echo -n "$f "
    git fame -esnwMC --incl "$f" | tr '/' '|' \
      | awk -F '|' '(NR>6 && $6>=30) {print $2}' \
      | xargs echo
  done
}

# terraform
alias tf='terraform'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfi='terraform init'
alias tfiu='terraform init -upgrade'
#alias tfswitch='tfswitch -b ~/.bin/terraform'

# terragrunt
alias tg='terragrunt'
alias tgp='terragrunt plan'
alias tga='terragrunt apply'
alias tgi='terragrunt init'
alias tgiu='terragrunt init -upgrade'

# ansible
alias av='ansible-vault'
alias ave='ansible-vault encrypt'
alias avd='ansible-vault decrypt'

# docker
alias docker='pgrep com.docker.hyperkit &> /dev/null || (open /Applications/Docker.app && until docker info &> /dev/null; do sleep 1; done) && docker'
alias docker-compose='pgrep com.docker.hyperkit &> /dev/null || (open /Applications/Docker.app && until docker info &> /dev/null ; do sleep 1; done) && docker-compose'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcr='docker-compose run --rm'
alias sen='docker run --rm --name sen -it -v /var/run/docker.sock:/run/docker.sock -e TERM tomastomecek/sen'

# kubernetes
alias kgp='kubectl get pod'

ke() {
    if [ -z $1 ]; then
        echo "Specify pod"
        return 1
    fi

    kubectl exec -it $1 -- $2
}

# ruby
alias be='bundle exec'
alias rb='bundle exec rubocop'
alias rba='bundle exec rubocop -a'
alias rbaa='bundle exec rubocop -A'
alias rgc='rake git:checkout'
alias gemunall='for x in `gem list --no-versions`; do gem uninstall $x -a -x -I; done'

# nodejs
alias spg='sort-package-json'

# misc
alias wh='which'
alias o='open .'
alias vi='nvim'
alias vim='nvim'
alias ze='vi ~/.zshrc'
alias zr='source ~/.zshrc'
alias vis='vi ~/.ssh/config'
alias vik='vi ~/.ssh/known_hosts'
alias sshcp='cat ~/.ssh/id_rsa.pub | pbcopy'
alias ip='curl ifconfig.co/json'
alias la='ls -la'
alias sa='ssh-add'
alias kg='ssh-keygen -t rsa -b 4096'
alias ic='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias df='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/.dotfiles'
alias fwe='sudo pfctl -e -f /etc/pf.conf'
alias fwd='sudo pfctl -d'
alias ttl='sudo sysctl -w net.inet.ip.ttl=65'
alias mtrr='mtr -s 1500 -r -n -c 1000 -i 0.1'
alias dflsh='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias ff720='ffmpeg -vf scale=-1:720 -crf 18 -preset ultrafast'
alias pwg='pwgen -Cs 15 1 | tr -d " " | tr -d "\n" | pbcopy'


bh() {
  local command
  command=$(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
  echo $command
  eval $command
}

sss() {
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

osef() {
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

osdf() {
    if [ ! -f "$1" ]; then
      echo "File does not exist"
      return
    fi

    openssl enc -aes-256-cbc -d -in "$1"
}

csrgn() {
    if [ -z $1 ]; then
        echo "Specify FQDN"
        return 1
    fi

    openssl req -newkey rsa:2048 -sha256 -nodes -keyout "${1}.key" -out "${1}.csr"
    openssl x509 -req -days 365 -in "${1}.csr" -signkey "${1}.key" -out "${1}.crt"
}

lvhgn() {
    openssl req -newkey rsa:2048 -x509 -nodes -keyout lvh.me.key -sha256 -days 3650 -new -out lvh.me.crt -subj '/CN=*.lvh.me' -reqexts SAN -extensions SAN -config <(cat /System/Library/OpenSSL/openssl.cnf <(printf '[SAN]\nsubjectAltName=DNS:lvh.me,DNS:*.lvh.me'))
}

attrcln() {
    if [ -e $1 ]; then
        echo "Specify the path"
        return 1
    fi

    chmod -RN $1
    xattr -rc $1
}

rstmd() {
    if [ -z $1 ]; then
        echo "Empty path"
        return 1
    fi

    find "$1" -type d -exec chmod 0755 {} \;
    find "$1" -type f -exec chmod 0644 {} \;
}

big() {
    find / -size +100M 2> /dev/null
}

dscln() {
  find . -name ".DS_Store" -exec rm {} \;
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

iconvr() {
    find . -type f -name '*.html' -o -name '*.html.erb' | while read file
    do
        echo $file
        iconv -f CP1251 -t UTF-8 "$file" > tmp
        mv -f tmp "$file"
    done
}

# tmp
alias cpm='cat ~/Yandex.Disk.localized/stuff/cpm.csv | grep'
alias awp-foh-old='export AWS_PROFILE=foh-old'
alias awp-foh-stg='export AWS_PROFILE=foh-staging'
alias awp-foh-prd='export AWS_PROFILE=foh-production'
