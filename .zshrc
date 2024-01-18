eval "$(starship init zsh)"

# import env
source ~/.config/zsh/env.zsh

# import aliases
source ~/.config/zsh/aliases.zsh

neofetch --kitty --source ~/.config/neofetch/nyarch.png

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Better History Navigation
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    cd "$(command lf -print-last-dir "$@")"
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


# Add autocorrection
setopt CORRECT

# Import Plugins 
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh/fzf-tab/fzf-tab.zsh
