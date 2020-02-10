" ----------------------------------------------------------------------------
" Common.vim - Settings that are shared between configurations.
" ----------------------------------------------------------------------------

" Settings
" --------
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set colorcolumn=79
    set timeout timeoutlen=1000 ttimeoutlen=50
    set termencoding=utf-8
    set encoding=utf-8
    set laststatus=2
    set cmdheight=1
    set showmode
    set nowrap
    set expandtab
    set autoindent
    set copyindent
    set showmatch
    set ignorecase
    set number
    set relativenumber
    set ttyfast

    let mapleader=","

" Syntax
" ------
    "set termguicolors
    syntax on

" Cursor
" ------
set guicursor=v:block-Cursor
set guicursor+=n-i:ver25-iCursor-blinkwait700-blinkon400-blinkoff250

" Remaps & Custom Commands
" ------------------------
    " Unhighlight after search
        nnoremap <CR> :noh<CR><CR>
    " Lambda character input
        inoremap <C-l> λ

    " Character delete shortcut
        inoremap <C-d> <Del>

    " 78-character line
        nnoremap ,l 78a-<ESC>

    " Underline line
        nnoremap ,ul yyp<c-v>$r-:Commentary<CR>$xx

    " Par format text
        set formatprg=par\ -jw60
        map <A-q> {v}!par -jw60<CR>
        vmap <A-q> !par -jw60<CR>

" Plugins
" -------
    " Better Whitespace
    :autocmd BufRead /usr/src/linux* DisableStripWhitespaceOnSave
    let g:better_whitespace_enabled=1
    let g:strip_whitespace_on_save=1
    let g:strip_whitespace_confirm=0
    let g:better_whitespace_filetypes_blacklist=['scratch', 'markdown', 'md', 'diff', 'gitcommit', 'unite', 'qf', 'help']

    " Commentary
    autocmd FileType c,cpp setlocal commentstring=//\ %s
    autocmd FileType way setlocal commentstring=#\ %s
    autocmd Syntax scheme,lisp setlocal commentstring=;;\ %s
    autocmd BufNewFile,BufRead *.scheme,*.scm setlocal commentstring=;;\ %s

    " NERDTree
    let g:NERDTreeWinSize=20
    " autocmd vimenter * NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    autocmd StdinReadPre * let s:std_in=1 autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    autocmd StdinReadPre * let s:std_in=1 autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
