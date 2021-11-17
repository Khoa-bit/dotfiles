# This alias relies on youtube-dl and ffmpeg packages
alias dls="youtube-dl -x --audio-format best --no-playlist "
alias dlpl="youtube-dl -x --audio-format best "
alias dlv="youtube-dl "
alias ls="exa -la --icons --group-directories-first"
alias activate-conda="source /opt/anaconda/bin/activate root"
alias deactivate-conda="conda deactivate"
alias cat='bat'
alias fzfcode="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
