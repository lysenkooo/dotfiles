export HISTSIZE="9999"
export HISTFILESIZE="9999"
export HISTCONTROL="ignoredups"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export SUDO_PS1="\w\\$ "
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

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/ctags/bin:$PATH" # brew --prefix ctags
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/usr/local/opt/node@10/bin:$PATH"
#export PATH="/usr/local/opt/php@7.0/bin:$PATH"
#export PATH="/usr/local/opt/php@7.0/sbin:$PATH"
#export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
#export PATH="/Applications/LibreOffice.app/Contents/MacOS:$PATH"
export PATH="`python3 -m site --user-base`/bin:$PATH"
export PATH="/Users/crashcube/Library/Python/2.7/bin:$PATH"
export PATH="~/.local/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

export LDFLAGS="-L/usr/local/opt/libffi/lib"
export CPPFLAGS="-I/usr/local/opt/libffi/include"

export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/opt/openssl/lib/pkgconfig"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/opt/libffi/lib/pkgconfig"

export PATH="/usr/local/opt/node@10/bin:$PATH"

if [ -f $HOME/.aliases ]; then
    source $HOME/.aliases
fi

if [ -f $HOME/.custom ]; then
    source $HOME/.custom
fi

GIT_PROMPT=/Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh

if [ -f $GIT_PROMPT ]; then
    source $GIT_PROMPT
    export PS1="\w\$(__git_ps1 '(%s)')\\$ "
else
    export PS1="\w\\$ "
fi

# GIT_COMPLETION=/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
# [ -s $GIT_COMPLETION ] && . $GIT_COMPLETION

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# _enter_dir() {
#     local git_root
#     git_root=$(git rev-parse --show-toplevel 2>/dev/null)

#     if [[ "$git_root" == "$PREV_PWD" ]]; then
#         return
#     elif [[ -n "$git_root" && -f "$git_root/.nvmrc" ]]; then
#         nvm use
#         NVM_DIRTY=1
#     elif [[ "$NVM_DIRTY" == 1 ]]; then
#         nvm use default
#         NVM_DIRTY=0
#     fi
#     PREV_PWD="$git_root"
# }

# export PROMPT_COMMAND=_enter_dir
export PATH="/usr/local/opt/ansible@2.8/bin:$PATH"
