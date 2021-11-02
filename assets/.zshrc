export ZSH="/Users/ccbe/.oh-my-zsh"
ZSH_THEME="af-magic"
DISABLE_AUTO_UPDATE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$PATH:/opt/homebrew/bin/"
export PATH="~/.local/bin:$PATH"
#export PATH="/usr/local/opt/openssl/bin:$PATH"
#export PATH="/usr/local/opt/ctags/bin:$PATH"
#export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
#export PATH="`python3 -m site --user-base`/bin:$PATH"
#export PATH="/usr/local/opt/node@12/bin:$PATH"

export HISTSIZE="9999"
export HISTFILESIZE="9999"
export HISTCONTROL="ignoredups"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
#export SUDO_PS1="\w\\$ "
export EDITOR="nvim"
export SVN_EDITOR="nvim"
export RBENV_ROOT="/usr/local/var/rbenv"
export ANSIBLE_HOST_KEY_CHECKING="False"
export OCI_DIR="$(brew --prefix)/lib"
export NLS_LANG="AMERICAN_AMERICA.UTF8"
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export DISABLE_AUTO_TITLE=true
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.private/gcloud.json
export SSLKEYLOGFILE=~/.ssl.log
export VAGRANT_DISABLE_VBOXSYMLINKCREATE=1
export DYLD_FORCE_FLAT_NAMESPACE="1"
export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$DYLD_LIBRARY_PATH
export BASH_SILENCE_DEPRECATION_WARNING=1
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export NODE_OPTIONS="--max_old_space_size=3072"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export LDFLAGS="-L/usr/local/opt/libffi/lib"
export CPPFLAGS="-I/usr/local/opt/libffi/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/opt/openssl/lib/pkgconfig"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/opt/libffi/lib/pkgconfig"

#eval "$(/opt/homebrew/bin/brew shellenv)"
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh

if [ -f $HOME/.aliases ]; then
    source $HOME/.aliases
fi

if [ -f $HOME/.custom ]; then
    source $HOME/.custom
fi
