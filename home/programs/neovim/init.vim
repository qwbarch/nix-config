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

" Make auto-complete suggestions cycle in the 'opposite' order.
" This sets it to what I'm used to from other programs.
let g:SuperTabDefaultCompletionType = "<c-n>"

set number
set wildmode=longest,list
set noswapfile

filetype plugin indent on
syntax on

colorscheme nord
hi Visual ctermbg=DarkGrey

" Disable backups due to issues with coc.nvim
set nobackup
set nowritebackup

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call CocActionAsync("doHover")<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Automatically format code on save.
"au BufWrite * :Autoformat

" Toggle the NERDTree file explorer.
nnoremap <C-t> :NERDTreeToggle<CR>

" Fuzzy find files/folders by name.
nnoremap <C-Space> :GFiles<CR>

" Fuzzy find files/folders by content.
nnoremap <C-n> :Rg<CR>

" Show git differences.
nnoremap <C-b> :GFiles?<CR>

" Show available code actions (e.g. imports).
nmap <leader><Space>  <Plug>(coc-codeaction)

" Open up a fuzzy finder hoogle window.
nmap <leader>f  :Hoogle<CR>

" Make ormolu aware of language extensions.
let g:ormolu_options= [
  \"-o -XTypeApplications",
  \"-o -XQuasiQuotes",
  \"-o -XTemplateHaskell",
  \"-o -XNegativeLiterals",
  \"-o -XNumericUnderscores"
\]

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" Show hidden files on NERDTree.
let NERDTreeShowHidden = 1
