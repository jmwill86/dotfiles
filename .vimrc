" Ensure you use sudo apt-get install vim-gtk3 -y when installing so you get the clipboard functionality
call plug#begin('~/.vim/plugged')
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'preservim/nerdcommenter'
Plug 'yggdroot/indentline'
Plug 'flazz/vim-colorschemes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'stanangeloff/php.vim'
Plug 'morhetz/gruvbox'
Plug 'evidens/vim-twig'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch' : 'release' }
Plug 'machakann/vim-highlightedyank'
Plug 'cespare/vim-toml'
Plug 'tpope/vim-surround'
"---- PHP Plugins ----"
Plug 'lumiliet/vim-twig'
call plug#end()
imap jj <Esc>
nmap <C-P> :Files<CR>
nmap <C-n> :NERDTreeToggle<CR>
let g:rehash256 = 1
let php_var_selector_is_identifier = 1
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
set hidden
let g:rustfmt_autosave = 1
set path+=**
set wildmenu
set number
set mouse=a
set guifont=Roboto\ Mono\ 12
set background=dark
set nowrap
set t_Co=256
set expandtab
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus
filetype plugin on
filetype plugin indent on
syntax enable
colorscheme gruvbox
"cmand! MakeTags !ctags -R .
