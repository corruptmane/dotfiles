let mapleader =','

call plug#begin('~/.local/share/nvim/plugged')

" alternative of vim-airline
Plug 'hoob3rt/lualine.nvim'
Plug 'ryanoasis/vim-devicons'

" color scheme
Plug 'joshdick/onedark.vim'

" for {}, (), [] etc.
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" python syntax
Plug 'vim-python/python-syntax'

" other stuff
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
Plug 'preservim/nerdtree'
Plug 'jamespeapen/swayconfig.vim'
Plug 'chrisbra/sudoedit.vim'

call plug#end()

lua << EOF
require'lualine'.setup {
    options = {
        theme = 'onedark'
    }
}
EOF

colorscheme onedark

set title
set mouse=a
set encoding=utf-8
set number relativenumber
set noswapfile
set scrolloff=5
set wildmode=longest,list,full

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set colorcolumn=88
set fileformat=unix
set splitbelow splitright

filetype indent on

if (has('termguicolors'))
  set termguicolors
endif

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" nerdtree
map <leader>n :NERDTreeToggle<CR>
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" another escape from insert mode
inoremap jk <esc>

" shortcutting split navigation, saving a keypress
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" python highlighting
let g:python_highlight_all = 1

" display an error message
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction
