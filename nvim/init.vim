
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'kristijanhusak/vim-packager', { 'type': 'opt' }
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'



Plug 'preservim/nerdcommenter'
Plug 'yggdroot/indentline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'stanangeloff/php.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'tpope/vim-fugitive' "For using :git.
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-surround'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kenn7/vim-arsync'
Plug 'jose-elias-alvarez/null-ls.nvim'
" LSP Support
Plug 'neovim/nvim-lspconfig'             " Required
Plug 'williamboman/mason.nvim'           " Optional
Plug 'williamboman/mason-lspconfig.nvim' " Optional
" Autocompletion Engine
Plug 'hrsh7th/nvim-cmp'         " Required
Plug 'hrsh7th/cmp-nvim-lsp'     " Required
Plug 'hrsh7th/cmp-buffer'       " Optional
Plug 'hrsh7th/cmp-path'         " Optional
Plug 'saadparwaiz1/cmp_luasnip' " Optional
Plug 'hrsh7th/cmp-nvim-lua'     " Optional
" Snippets
Plug 'L3MON4D3/LuaSnip'             " Required
Plug 'rafamadriz/friendly-snippets' " Optional
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v1.x'}

call plug#end()

lua require('setup')

imap jj <Esc>
nmap <C-P> :Telescope find_files<CR>
nmap <C-F> :Telescope live_grep<CR>
nmap <C-n> :NvimTreeToggle<CR>
let g:rehash256 = 1
"let php_var_selector_is_identifier = 1
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:db_ui_auto_execute_table_helpers = 1
set hidden
let g:rustfmt_autosave = 1
set path+=**
set wildmenu
set number
set mouse=a
set guifont=Roboto\ Mono\ 12
set nowrap
set t_Co=256
set expandtab
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus
filetype plugin on
filetype plugin indent on
syntax enable

if has('termguicolors')
    set termguicolors
endif

set background=dark
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_background = 'normal'
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material
