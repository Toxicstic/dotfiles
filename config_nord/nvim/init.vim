call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'chemzqm/vim-jsx-improve'
Plug 'jiangmiao/auto-pairs'
call plug#end()

colorscheme nord
filetype plugin indent on
set number
set nowrap
set mouse=a
set ignorecase
set encoding=utf-8
set scrolloff=3
syntax enable
set noerrorbells
set laststatus=2
set cursorline
set title
set foldmethod=manual
set foldnestmax=5
