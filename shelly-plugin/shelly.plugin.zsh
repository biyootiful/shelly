# Shelly Oh My Zsh Plugin

# Add shelly to PATH if it's installed
if [ -d "$HOME/.shelly" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Source the trap functions for error catching
if [ -f "$HOME/.shelly/shelly-trap" ]; then
    source "$HOME/.shelly/shelly-trap"
fi

# Convenience aliases
alias s='shelly'
alias shelp='shelly_catch'

# Quick helpers
alias scmd='shelly "what is the command for"'
alias sfix='shelly_catch'
