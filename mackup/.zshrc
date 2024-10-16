# Profiler Begin
# zmodload zsh/zprof

plugins=(
  git
  zsh-syntax-highlighting
  zsh-z
  fzf-zsh-plugin
#  you-should-use
)

ZSH="/Users/ccbe/.oh-my-zsh"
ZSH_THEME="af-magic"
DISABLE_AUTO_UPDATE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

if [[ "$USER" == "root" ]]; then
  PS1="%F{green}%~\$(git_prompt_info)\$(hg_prompt_info) %F{red}%(!.#.»)%f "
  RPS1=""
else
  PS1="${FG[032]}%~\$(git_prompt_info)\$(hg_prompt_info) ${FG[105]}%(!.#.»)%{$reset_color%} "
  RPS1=""
fi

source $ZSH/oh-my-zsh.sh

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

export LDFLAGS="${LDFLAGS} -L/opt/homebrew/opt/postgresql@15/lib"
export CPPFLAGS="${CPPFLAGS} -I/opt/homebrew/opt/postgresql@15/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/opt/homebrew/opt/postgresql@15/lib/pkgconfig"

export PGGSSENCMODE="disable"

#export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/homebrew/opt/openssl@1.1"

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
#eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="bin:$HOME/.bin:$HOME/.local/bin:$PATH"

eval "$(/opt/homebrew/bin/mise activate zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#export PYENV_ROOT="$HOME/.pyenv"
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
#export PATH="$HOME/.pyenv/shims:$PATH"

#export NVM_DIR="$HOME/.nvm"
#[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
#[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

#source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
#source /opt/homebrew/opt/chruby/share/chruby/auto.sh

export NODE_OPTIONS="--max-old-space-size=4096"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# development
alias vs='code .'
alias cr='cursor .'
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
    brew services run postgresql@15
    brew services run redis
}

nocode() {
    brew services stop postgresql@15
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
alias grs='git reset'
alias gs='git status'
alias gd='git diff'
alias gdn='git diff --name-status'
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
alias grmi='git fetch && git rebase -i origin/main'
alias grdi='git fetch && git rebase -i origin/develop'
alias gmm='git fetch && git rebase && git merge --ff origin/main'
alias gmd='git fetch && git rebase && git merge --ff origin/develop'
alias gfp='git fetch --prune'
alias gl='git pull'
alias glr='git pull --rebase'
alias glrb='git pull --rebase'
alias gp='git push'
alias gpf='git push -f'
alias gpo='git push -u origin HEAD'
alias gpof='git push -u origin HEAD -f'
alias ghpr='open https://github.com/pulls'
alias ghcr='open https://github.com/pulls/review-requested'
alias ghprv='gh pr view --web'
alias ghprc='gh pr create'
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

giw() {
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD)

  if [[ $branch == "main" ]] || [[ $branch == "develop" ]]; then
    echo "Man, you're in $branch branch"
    return 1
  fi

  git commit -a -m WIP
}

giwp() {
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD)

  if [[ $branch == "main" ]] || [[ $branch == "develop" ]]; then
    echo "Man, you're in $branch branch"
    return 1
  fi

  git commit -a -m WIP && git push
}

unalias gg
gg() {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf +s +m -e) &&
  git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
}

gfall() {
  local root=$(pwd)

  for f in *; do
    local p="$root/$f"

    if [ -d "$p/.git" ]; then
      echo "------------------------------------------------------------"
      echo "$p"
      cd "$p"
      git diff --name-status
      git fetch --all --prune
      git pull --all || true

      if [ ! -z "$1" ]; then
        git checkout "$1"
        git rebase
      fi
    fi
  done

  cd "$root"
}

gdall() {
  local root=$(pwd)

  for f in *; do
    local p="$root/$f"

    if [ -d "$p/.git" ]; then
      echo "------------------------------------------------------------"
      echo "$p"
      cd "$p"
      git diff --name-status
    fi
  done

  cd "$root"
}

owners() {
  for f in $(git ls-files); do
    echo -n "$f "
    git fame -esnwMC --incl "$f" | tr '/' '|' \
      | awk -F '|' '(NR>6 && $6>=30) {print $2}' \
      | xargs echo
  done
}

unalias gbr
gbr() {
  local BR=$(git rev-parse --abbrev-ref HEAD)
  local DST=${1}
  local SRC=${2:="$BR"}

  if [ -z "$DST" ]; then
      echo "DST branch is empty"
      return 1
  fi

  echo "Reset $DST from $SRC"
  git branch -D "$DST"
  git checkout -b "$DST" "origin/$SRC" && git push -u -f origin HEAD
}

# terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfiu='terraform init -upgrade'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfo='terraform output'

alias tg='terragrunt'
alias tgi='terragrunt init'
alias tgiu='terragrunt init -upgrade'
alias tgp='terragrunt plan'
alias tga='terragrunt apply'
alias tgo='terragrunt output'

# ansible
alias av='ansible-vault'
alias ave='ansible-vault encrypt'
alias avd='ansible-vault decrypt'

# docker
alias ds='colima start --arch aarch64 --vm-type=vz --vz-rosetta'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcr='docker-compose run --rm'
alias sen='docker run --rm --name sen -it -v /var/run/docker.sock:/run/docker.sock -e TERM tomastomecek/sen'
alias drrm='docker run --rm'
alias drrmit='docker run --rm -it'
alias deit='docker exec -it'

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
alias ss='bin/spring stop'

# nodejs
alias spg='sort-package-json'
alias nr='npm run'
alias yr='yarn run'
alias yu='yarn upgradeInteractive'

# misc
alias ai='aichat'
alias aie='aichat -e'
alias wh='which'
alias o='open .'
alias vi='nvim'
alias vim='nvim'
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
alias dns-flush='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias dns-sniff='sudo tshark -f "src port 53" -n -T fields -e dns.qry.name'
alias ff720='ffmpeg -vf scale=-1:720 -crf 18 -preset ultrafast'
alias pwg='pwgen -Cs 15 1 | tr -d " " | tr -d "\n" | pbcopy'
alias spdtst='curl https://speedtest.selectel.ru/100MB -o/dev/null'
alias nl='nslookup'
alias iprf='iperf3-darwin -c 192.168.1.1'

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

cln() {
  find . -name ".DS_Store" -exec rm {} \;
  find . -empty -type d -delete
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

vpn() {
  CONNECTION="Stockholm"

  if [[ $(scutil --nc list | grep "Connected" | grep "$CONNECTION") ]]; then
    scutil --nc stop "$CONNECTION"
  else
    scutil --nc start "$CONNECTION"
  fi
}

awsp() {
  if [[ "$1" == "production" ]]; then
    export AWS_PROFILE=foh-production
    aws sts get-caller-identity
    aws eks update-kubeconfig --name production --region us-east-1
  elif [[ "$1" == "staging" ]]; then
    export AWS_PROFILE=foh-staging
    aws sts get-caller-identity
    aws eks update-kubeconfig --name staging --region us-east-1
  elif [[ "$1" == "legacy" ]]; then
    export AWS_PROFILE=foh-staging
    aws sts get-caller-identity
  else
    echo "Unknown profile"
    return 1
  fi
}

alias viz='vi ~/.zshrc'
alias vit='vi ~/.tmux.conf'
alias vik='vi ~/.ssh/known_hosts'

vis() {
  if [[ -z "$1" ]]; then
    vi ~/.ssh/config
  else
    vi ~/.ssh/config.${1}
  fi
}

tgz() {
  if [[ ! -d "$1" ]]; then
    echo "Folder $1 does not exist"
    return
  fi

  tar -czf "$1-$(date +%Y%m%d).tar.gz" "$1"
}

sstpc-kn() {
  if [[ -z "$1" ]]; then
    echo "Name is empty"
    return
  fi

  if [[ -z "$SSTP_PASS" ]]; then
    echo "SSTP_PASS is empty"
    return
  fi

  sudo sstpc --log-stdout --log-level INFO --cert-warn --tls-ext --user admin --password "${SSTP_PASS}" "$1.keenetic.pro" usepeerdns require-mschap-v2 noauth noipdefault noccp refuse-eap refuse-pap refuse-mschap
}

oc-setup() {
  mkdir -p "$HOME/.openconnect"
  echo -e "#!/bin/sh\nexport INTERNAL_IP4_DNS=192.168.1.1\nsource /opt/homebrew/etc/vpnc/vpnc-script" > "$HOME/.openconnect/vpnc-nodns"
  echo -e "OC_USER=\nOC_PASS=\nOC_GROUP=\nOC_HOST=" > "$HOME/.openconnect/sample-profile"
  sudo sh -c 'echo "%admin ALL=(ALL) NOPASSWD: /opt/homebrew/bin/openconnect, /bin/kill" > /etc/sudoers.d/openconnect'
}

occ() {
  if [[ -z "$1" ]]; then
    echo "Profile name is empty"
    return
  fi

  if [[ ! -f "$HOME/.openconnect/$1" ]]; then
    echo "Profile "$1" is not found"
    return 1
  fi

  if [[ -f "$HOME/.openconnect/.pid" ]]; then
    echo "Already running"
    return 1
  fi

  source "$HOME/.openconnect/$1"

  echo "$OC_PASS" | sudo openconnect --non-inter --background --pid-file="$HOME/.openconnect/.pid" --user="$OC_USER" --authgroup="$OC_GROUP" "$OC_HOST" --passwd-on-stdin -s "$HOME/.openconnect/vpnc-nodns" --quiet > "$HOME/.openconnect/log" 2>&1
  sleep 1
  netstat -nr -f inet | grep 'G' --color=none | tail -n +2
}

ocd() {
  if [[ -f "$HOME/.openconnect/.pid" ]]; then
    sudo kill -2 $(cat "$HOME/.openconnect/.pid")
    rm -f "$HOME/.openconnect/.pid"
    sleep 1
    netstat -nr -f inet | grep 'G' --color=none | tail -n +2
  else
    echo "OpenConnect pid file does not exist, probably not running"
  fi
}

ks() {
  sudo hidutil property --matching '{"ProductID":0x29a}' --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064},{"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035}]}'
}

denv() {
  export $(sed -e 's/=\(.*\)/="\1"/g' .env | grep -v "#" | xargs)
}

# tmp
alias aws-mfa='aws sts get-session-token --serial-number arn:aws:iam::102684285154:mfa/Authenticator --token-code'
alias cpm='cat ~/Yandex.Disk.localized/stuff/cpm.csv | grep'

# autoload -Uz compinit

# if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
#   compinit;
# else
#   compinit -C;
# fi;

# if type brew &>/dev/null; then
#   FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

#   autoload -Uz compinit
#   compinit
# fi
#

if [ -f $(brew --prefix)/etc/zsh_completion ]; then
. $(brew --prefix)/etc/zsh_completion
fi

if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi

# Profiler End
# zprof
