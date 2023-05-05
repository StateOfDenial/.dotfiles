# Setup brew 

os=$(uname)

if "$os" == "Darwin" then
    eval "$(brew shellenv)"
else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
    
export PATH="$HOME/.local/scripts:$PATH"
