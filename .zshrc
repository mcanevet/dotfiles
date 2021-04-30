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
	zinit-zsh/z-a-readurl \
	zinit-zsh/z-a-patch-dl \
	zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh
zinit snippet OMZ::plugins/aws/aws.plugin.zsh
zinit snippet OMZ::plugins/gpg-agent/gpg-agent.plugin.zsh

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

zinit wait"1" lucid from"gh-r" as"null" for \
	sbin"argocd-linux-amd64 -> argocd" argoproj/argo-cd \
	sbin"aspiratv" simulot/aspiratv \
	sbin"chroma" alecthomas/chroma \
	sbin"bin/exa" ogham/exa \
	sbin"usr/local/bin/exo" exoscale/cli \
	sbin"fx-linux -> fx" antonmedv/fx \
	sbin"helmfile_linux_amd64 -> helmfile" roboll/helmfile \
	sbin"k3d-linux-amd64 -> k3d" rancher/k3d \
	sbin"k9s" derailed/k9s \
	sbin"kustomize" kubernetes-sigs/kustomize \
	sbin"usr/local/bin/sops" mozilla/sops \
	sbin"summon" cyberark/summon \
	sbin"yh" andreazorzetto/yh \
	sbin"yq_linux_amd64 -> yq" mikefarah/yq

zinit ice from"gh-r" ver"v1.9.2" as"program" bpick"*-linux-amd64.tar.gz" \
	atclone"./gopass completion zsh > _gopass" atpull'%atclone' \
	pick"gopass-*/gopass"
zinit load gopasspw/gopass

zinit ice id-as"kubectl" lucid pick"kubectl/kubectl" as"program" \
	atclone"./kubectl completion zsh > _kubectl" atpull'%atclone'
zinit snippet https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

zinit id-as"helm" as="readurl|command" extract \
	pick"linux-amd64/helm" \
	dlink"https://get.helm.sh/helm-v%VERSION%-linux-amd64.tar.gz" \
	for https://github.com/helm/helm/releases/

zinit id-as'terraform' as'readurl|command' extract \
	dlink0'/terraform/%VERSION%/~%.*-(alpha|beta).*%' \
	dlink'/terraform/%VERSION%/terraform_%VERSION%_linux_amd64.zip' \
	for https://releases.hashicorp.com/terraform/

# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma/history-search-multi-word

zinit wait lucid light-mode for \
	atinit"zicompinit; zicdreplay" \
		zdharma/fast-syntax-highlighting \
	atload"_zsh_autosuggest_start" \
		zsh-users/zsh-autosuggestions \
	blockf atpull'zinit creinstall -q .' \
		zsh-users/zsh-completions

# Aliases
alias l='exa'
alias la='exa -a'
alias ll='exa -lah'
alias ls='exa --color=auto'

export PATH="$HOME/.local/bin:$PATH"
export SUMMON_PROVIDER="$HOME/bin/summon-gopass"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
