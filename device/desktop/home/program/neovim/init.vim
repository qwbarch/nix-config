set nocompatible
set nofixendofline
set showmode
set showmatch
set ignorecase
set hlsearch
set incsearch
set laststatus=0

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartcase
set smartindent
set smarttab

set number
set relativenumber
set wildmode=longest,list
set noswapfile

filetype plugin indent on
syntax on

" Disable backups due to issues with coc.nvim
set nobackup
set nowritebackup

" Make auto-complete suggestions cycle in the opposite order.
let g:SuperTabDefaultCompletionType = "<c-n>"

" Toggle NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
