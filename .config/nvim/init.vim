" Plugins
call plug#begin($HOME . '/.config/nvim/plugins')
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'tpope/vim-commentary'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'rust-lang/rust.vim'
    Plug 'alaviss/nim.nvim'
    Plug 'mileszs/ack.vim'
    Plug 'tpope/vim-obsession'
    Plug 'dhruvasagar/vim-prosession'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'mtth/scratch.vim'
    Plug 'kongo2002/fsharp-vim'
    Plug 'kyoto-shift/on.vim'
call plug#end()

runtime common.vim
