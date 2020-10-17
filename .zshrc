# Skip the not really helping Debian global compinit
skip_global_compinit=1

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

zinit ice blockf
zinit light zsh-users/zsh-completions

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit ice as"program" pick"bin/git-dsf"
zinit light zdharma/zsh-diff-so-fancy

zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS
alias ls='ls --color=auto'

zinit ice from"gh-r" as"program" mv"direnv* -> direnv" \
    atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
    pick"direnv" src="zhook.zsh"
zinit load direnv/direnv

zinit ice from"gh-r" as"program" mv"yq_linux_amd64 -> yq"
zinit load mikefarah/yq

zinit ice from"gh-r" as"program"
zinit load simulot/aspiratv

zinit ice from"gh-r" as"program" mv"argocd-linux-amd64 -> argocd"
zinit load argoproj/argo-cd

zinit ice from"gh-r" as"program"
zinit load cyberark/summon

zinit ice from"gh-r" as"program" pick"usr/local/bin/sops"
zinit load mozilla/sops

zinit ice from"gh-r" ver"v1.9.2" as"program" bpick"*-linux-amd64.tar.gz" \
    atclone"./gopass completion zsh > _gopass" atpull'%atclone' \
    pick"gopass-*/gopass"
zinit load gopasspw/gopass

zinit ice lucid wait'1' id-as'kubectl' null sbin"kubectl"
zinit snippet https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

zinit ice from"gh-r" as"program"
zinit load derailed/k9s

zinit ice from"gh-r" as"program" mv"k3d-linux-amd64 -> k3d"
zinit load rancher/k3d

zinit ice from"gh-r" as"program"
zinit load kubernetes-sigs/kustomize

zinit id-as"helm" as="monitor|command" extract \
	pick"linux-amd64/helm" \
	dlink"https://get.helm.sh/helm-v%VERSION%-linux-amd64.tar.gz" \
	for https://github.com/helm/helm/releases/

zinit ice from"gh-r" as"program" mv"helmfile_linux_amd64 -> helmfile"
zinit load roboll/helmfile

zinit id-as'terraform' as'readurl|command' extract \
	dlink0'/terraform/%VERSION%/' \
	dlink'/terraform/%VERSION%/terraform_%VERSION%_linux_amd64.zip' \
	for https://releases.hashicorp.com/terraform/

zinit ice from"gh-r" as"program"
zinit load alecthomas/chroma

# ogham/exa, replacement for ls
zinit ice wait"2" lucid from"gh-r" as"program" mv"exa* -> exa"
zinit light ogham/exa

zinit ice from"gh-r" as"program" mv"fx-linux -> fx"
zinit load antonmedv/fx

zinit ice from"gh-r" as"program"
zinit load andreazorzetto/yh

zinit ice from"gh-r" as"program" bpick"youtube-dl"
zinit load ytdl-org/youtube-dl

# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
zinit ice atinit'zicompinit'
zinit light zdharma/fast-syntax-highlighting

# Aliases
alias l='exa'
alias la='exa -a'
alias ll='exa -lah'
alias ls='exa --color=auto'

export PATH="$HOME/.local/bin:$PATH"
export SUMMON_PROVIDER="$HOME/bin/summon-gopass"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
