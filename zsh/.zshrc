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
alias ls='ls --color=always'
alias la='ls -la --color=always'

export PATH="$HOME/.local/scripts:$PATH"
export PATH="$HOME/.local/kitty.app/bin:$PATH"
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

autoload -U +X bashcompinit && bashcompinit

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(goenv init -)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# enable fzf binds on shell
export FZF_CTRL_R_OPTS="--height 60% \
    --border sharp \
    --layout reverse"

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

export LDFLAGS="-Wl,-rpath,$(brew --prefix openssl)/lib" 
export CPPFLAGS="-I$(brew --prefix openssl)/include" 
export CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl)"

export ZPLUG_HOME=$(brew --prefix zplug)
source $ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/terraform", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
#zplug "spaceship-prompt/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug romkatv/powerlevel10k, from:github, as:theme, depth:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History settings
export HISTFILE=~/.history
export HISTSIZE=500000
export SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running i

# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey '^[[1;5D' backward-word
# [Alt-RightArrow] - move to end of line
bindkey '^[[1;3C' end-of-line
# [Alt-LeftArrow] - move to start of line
bindkey '^[[1;3D' beginning-of-line
