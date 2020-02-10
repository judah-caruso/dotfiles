" Plugins
call plug#begin($HOME . '/.config/nvim/plugins')
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'tpope/vim-commentary'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'rust-lang/rust.vim'
    Plug 'alaviss/nim.nvim'
call plug#end()

runtime common.vim
