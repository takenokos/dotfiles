autoload -U compinit
compinit
#echo "            _ _         _        _                    _                 _"
#echo "  /\  /\___| | | ___   | |_ __ _| | _____ _ __   ___ | | _____  ___    / \ "
#echo " / /_/ / _ \ | |/ _ \  | __/ _\` | |/ / _ \ '_ \ / _ \| |/ / _ \/ __|  /  / "
#echo "/ __  /  __/ | | (_) | | || (_| |   <  __/ | | | (_) |   < (_) \__ \ /\_/ "
#echo "\/ /_/ \___|_|_|\___/   \__\__,_|_|\_\___|_| |_|\___/|_|\_\___/|___/ \/ "

export XDG_CONFIG_HOME="$HOME/.config"
export ANDROID_HOME=$HOME/Library/Android/sdk

if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  BREW_HOME="/opt/homebrew"  # 新版 macOS
else
  # Linux
  BREW_HOME="/home/linuxbrew/.linuxbrew"
fi

export PATH=$HOME/.local/bin:$HOME/.bun/bin:$HOME/.cargo/bin:$BREW_HOME/bin:$BREW_HOME/opt/llvm/bin:$HOME/.console-ninja/.bin:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH

export EDITOR=hx

# plugins
source ~/.zsh/git-open/git-open.plugin.zsh
source ~/.zsh/ohmyzsh-plugins-git/git.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
# end plugins

eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

eval "$(mise activate zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

#alias
alias cd=z
alias ls="eza --icons=always --hyperlink"

alias find=fd
alias grep=rg
alias du=dust
alias ps=procs
alias cat=bat

alias hitokoto="curl -sL https://v1.hitokoto.cn/\?encode\=json | jq '.hitokoto'"

alias python=python3
alias py=python
alias py3=python3
# ngrok
if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
fi

# yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
# end yazi

# broot
source ~/.config/broot/launcher/bash/br

# jj
source <(jj util completion zsh)

fastfetch

# fast-theme
fsh_theme=$(fast-theme -s | sed 's/\x1b\[[0-9;]*m//g')
main_theme=$(echo "$fsh_theme" | grep "Main theme" | awk -F': ' '{print $2}' | tr -d ' \t\r\n')
current_active=$(echo "$fsh_theme" | grep "Currently active theme" | awk -F': ' '{print $2}' | tr -d ' \t\r\n')
if [ "$main_theme" != "catppuccin-macchiato" ] || [ "$current_active" != "catppuccin-macchiato" ]; then
  fast-theme XDG:catppuccin-macchiato
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PUB_HOSTED_URL="https://mirror.nju.edu.cn/dart-pub"
export FLUTTER_STORAGE_BASE_URL="https://mirror.sjtu.edu.cn"
