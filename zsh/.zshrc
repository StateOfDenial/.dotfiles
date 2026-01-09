ssh-reagent() {
    if ! ps -e | grep ssh-agent >/dev/null; then
        eval `ssh-agent -s`
    fi
    export SSH_AUTH_SOCK=$(echo /tmp/ssh-*/agent.*)
    ssh-add -l > /dev/null || ssh-add
}

ssh-reagent
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias vim="nvim"
alias v="nvim"
alias ls='ls --color=always'
alias la='ls -la --color=always'
alias tf='terraform'

export PATH="$HOME/.local/scripts:$PATH"
export PATH="$HOME/.local/kitty.app/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/lib:$PATH"

export EDITOR="nvim"

if [ -d /home/linuxbrew ]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

autoload -U +X bashcompinit && bashcompinit

if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

if command -v goenv &>/dev/null; then
  eval "$(goenv init -)"
fi

if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if command -v brew >/dev/null; then
    export LDFLAGS="-Wl,-rpath,$(brew --prefix openssl)/lib" 
    export CPPFLAGS="-I$(brew --prefix openssl)/include" 
    export CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl)"
fi

# Get gcloud completion if it is installed
if [ -f /usr/lib/google-cloud-sdk/completion.bash.inc ]; then
    . /usr/lib/google-cloud-sdk/completion.bash.inc
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Work related things
[[ ! -f ~/.wprc ]] || source ~/.wprc

# If batcat is installed, alias cat
if command -v batcat &>/dev/null; then
    alias cat=batcat
fi

if command -v fzf &>/dev/null; then
    # eval "$(fzf --zsh)"
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
    export FZF_DEFAULT_OPTS='--preview "batcat -n --color always --line-range :50 {}"'
    export FZF_CTRL_R_OPTS="
     --preview 'echo {}' --preview-window up:3:hidden:wrap
     --bind 'ctrl-/:toggle-preview'
     --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'"
fi

if command -v gh &>/dev/null; then
    eval "$(gh completion --shell zsh)"
fi

bindkey -v
bindkey '^y' autosuggest-accept

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# History settings
export HISTFILE=~/.history
export HISTSIZE=500000
export SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups # ignor dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running i
