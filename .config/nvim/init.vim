scriptencoding utf-8

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	augroup pluginstall
		autocmd!
		autocmd VimEnter * PlugInstall
	augroup END
endif

" Install plugins
call plug#begin()

" Languages plugins
Plug 'ekalinin/Dockerfile.vim'
Plug 'rodjek/vim-puppet'
Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'vim-scripts/groovy.vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'towolf/vim-helm'
Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; ./generate.py' }
Plug 'vim-ruby/vim-ruby'
Plug 'mrk21/yaml-vim'
Plug 'ngmy/vim-rubocop'

" File syntax plugins
Plug 'aouelete/sway-vim-syntax'
Plug 'zinit-zsh/zinit-vim-syntax'
Plug 'vim-scripts/haproxy'

" Not configurable plugins
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'Einenlum/yaml-revealer'

" Configurable plugins
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'simnalamburt/vim-mundo'
Plug 'machakann/vim-highlightedyank'
Plug 'gruvbox-community/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'

" Asynchronous linting/fixing for Vim and Language Server Protocol (LSP) integration
"
" sudo apt install ansible-lint gitlint jq proselint puppet puppet-lint rubocop shellcheck
"
" pip3 install --user vim-vint
"
" git clone https://github.com/hadolint/hadolint
" cd hadolint
" stack install
"
" go get github.com/mrtazz/checkmake
" cd $GOPATH/src/github.com/mrtazz/checkmake
" make
"
" wget https://github.com/wata727/tflint/releases/download/v0.7.2/tflint_linux_amd64.zip

call plug#end()

" Settings
set relativenumber  " Show line numbers
set noswapfile      " Don't use swapfile
set noshowmode      " We show the mode with airline
set ignorecase      " Search case insensitive...
set smartcase       " ... but not when search pattern contains upper case characters
set tabstop=4
set shiftwidth=4
set colorcolumn=80
set cursorline
set scrolloff=5
set mouse+=a
set list listchars=tab:→\ ,trail:·
set autochdir

" The highlighting starts by default 50 lines above the cursor,
" in some files, it is not enough, so look 300 lines above (may be slower)

syntax sync minlines=300

let mapleader = ','

" Plugins config

" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.terraform = '[^ *\t"{=$]\w*'
call deoplete#initialize()

" Configure ALE
let g:ale_fixers = {
			\   '*': ['remove_trailing_lines', 'trim_whitespace'],
			\   'puppet': ['puppetlint'],
			\   'javascript': ['eslint'],
			\   'ruby': ['rubocop'],
			\}
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1

" Configure vim-commentary
augroup vimcommentary
	autocmd!
	autocmd FileType terraform setlocal commentstring=#%s
augroup END

au BufRead,BufNewFile haproxy* set ft=haproxy

" Configure vim-terraform
let g:terraform_align=1
let g:terraform_fold_sections=0
let g:terraform_remap_spacebar=1
let g:terraform_fmt_on_save=1

" Configure vim-go
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_fmt_command = 'goimports'

" Set colorscheme
set background=dark
set termguicolors
let g:gruvbox_italic=1
colorscheme nord

" Enable persistent undo so that undo history persists across vim sessions
set undofile

" Configure mundo
nnoremap <F5> :MundoToggle<CR>

" Diable Arrow keys in Escape mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Retab
nmap <leader>2 :set shiftwidth=2<CR>:set tabstop=2<CR>:set softtabstop=2<CR>:set expandtab<CR>
nmap <leader>4 :set shiftwidth=4<CR>:set tabstop=4<CR>:set softtabstop=4<CR>:set expandtab<CR>
nmap <leader>8 :set shiftwidth=8<CR>:set tabstop=8<CR>:set softtabstop=8<CR>:set expandtab<CR>
