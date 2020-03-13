" ----------------------------------------------------------------------------
" Common.vim - Settings that are shared between configurations.
" ----------------------------------------------------------------------------

" Settings
" --------
	" set colorcolumn=79
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set timeout timeoutlen=1000 ttimeoutlen=50
	set termencoding=utf-8
	set encoding=utf-8
	set laststatus=2
	set cmdheight=1
	set showmode
	set nowrap
	set noexpandtab " expandtab
	set autoindent
	set copyindent
	set showmatch
	set ignorecase
	set number
	set relativenumber
	set ttyfast

	let mapleader=","

	set list
	set listchars=tab:·\ ,trail:·,nbsp:⎵
	" set listchars=tab:——,trail:·,nbsp:⎵

" Syntax
" ------
	syntax on

	" JSX
	autocmd BufNewFile,BufRead *.jsx,*.tsx,*.ts,*.js set syntax=javascript

	" Only highlight characters on the 79th column (apposed to: colorcolumn=79)
		call matchadd('ColorColumn', '\%79v', 100)

	" Small changes
		highlight ColorColumn	ctermbg=blue		ctermfg=black
		highlight Visual		ctermbg=grey		ctermfg=black
		highlight MatchParen	ctermbg=black		ctermfg=white

	" Fix fold colors
		highlight Folded		ctermfg=black		ctermbg=darkgrey
		highlight FoldColumn	ctermfg=blue		ctermbg=darkgrey

	" Fix SpellRare
		highlight SpellRare		ctermfg=white

	" Fix character colors
		highlight Whitespace	ctermfg=0x80a0ff

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
		nnoremap <Leader>l 78a-<ESC>

	" Underline line
		nnoremap <Leader>ul yyp<c-v>$r-:Commentary<CR>$xx

	" Time+Name Comment
		nnoremap <Leader>t $:pu=strftime('%Y/%m/%d [%l:%M %p]')<CR>:Commentary<CR>:r!git config --get user.name<CR>i<BS><SPACE><ESC>^i<BS><SPACE><ESC>
		nmap <Leader>rt f<SPACE>d$<Leader>t

	" Par format text
		set formatprg=par\ -jw60
		map <A-q> {v}!par -jw60<CR>
		vmap <A-q> !par -jw60<CR>

	" Artistic Style C
		nmap <Leader>a :%!astyle<CR><ESC><C-O>

	" Swap between header and source
		function! ToggleHeader()
			let extension = split(expand("%"), '\.')[-1]

			if extension == "c"
				:e %<.h
			endif

			if extension == "cpp"
				:e %<.hpp
			endif

			if extension == "h"
				:e %<.c
			endif

			if extension == "hpp"
				:e %<.cpp
			endif
		endfunction

		nnoremap <Leader>h :call ToggleHeader()<CR>


" Plugins
" -------

	" Go
	let g:go_fmt_command="goimports"

	" Ack.vim
	if executable('ag')
		let g:ackprg = 'ag --vimgrep'
	endif

	" Fzy + ag
	function! FzyCommand(choice_command, vim_command) abort
		let l:callback = {
					\ 'window_id': win_getid(),
					\ 'filename': tempname(),
					\ 'vim_command':  a:vim_command
					\ }

		function! l:callback.on_exit(job_id, data, event) abort
			bdelete!
			call win_gotoid(self.window_id)
			if filereadable(self.filename)
				try
					let l:selected_filename = readfile(self.filename)[0]
					exec self.vim_command . l:selected_filename
				catch /E684/
				endtry
			endif
			call delete(self.filename)
		endfunction

		botright 10 new
		let l:term_command = a:choice_command . ' | fzy > ' .  l:callback.filename
		silent call termopen(l:term_command, l:callback)
		setlocal nonumber norelativenumber
		startinsert
	endfunction

	nnoremap <leader>fe :call FzyCommand("ag . --silent -l -g ''", ":e ")<cr>
	nnoremap <leader>fv :call FzyCommand("ag . --silent -l -g ''", ":vs ")<cr>
	nnoremap <leader>fs :call FzyCommand("ag . --silent -l -g ''", ":sp ")<cr>

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
