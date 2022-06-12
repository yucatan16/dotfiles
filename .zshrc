DEFAULT=$'\U1F603 '
ERROR=$'\U1F92E '
PROMPT=%~"%(?.${DEFAULT}.${ERROR})"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export PATH="~/.rbenv/shims:/usr/local/bin:$PATH"
eval "$(rbenv init - zsh)"
eval "$(direnv hook zsh)"
setopt nonomatch

alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

fpath=(
  ${HOME}/.zsh/completions
  ${fpath}
)
autoload -Uz compinit
compinit

# export GOENV_ROOT=$HOME/.goenv
# export PATH=$GOENV_ROOT/bin:$PATH
# export PATH=$HOME/.goenv/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

export PATH="$HOME/.embulk/bin:$PATH"
export PATH="/usr/local/opt/python@3.8/libexec/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# peco settings
peco-src () {
    local repo=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        BUFFER="cd ${repo}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# eure settings
alias ssm_port_forwarder.sh="$HOME/work/github.com/eure/utility-scripts/aws/gateway/ssm_port_forwarder.sh"
alias ssm_gateway_connector.sh="$HOME/work/github.com/eure/utility-scripts/aws/gateway/ssm_gateway_connector.sh"