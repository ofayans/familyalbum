":match ErrorMsg /\%>73v.\+/
:set statusline=%F%m%r%h%w\ [POS=%04l,%04v][%p%%]\
":set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
:set laststatus=2
:set tabline=tabline-layout
:set tabline=%!ShortTabLine()
:set cursorline
:set incsearch "incremental search is pretty cool"
:set ignorecase
:set hlsearch "highlight the search results"
":set cursorcolumn
:set number
":set spell
":set spelllang=en,ru
:set foldmethod=indent
:set foldlevel=1
:set foldnestmax=4
:set nofoldenable
:set rtp+=~/.vim/bundle/Vundle.vim
:setlocal foldmethod=indent
call vundle#begin()
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
 
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
 
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.
                    
 
set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.

set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).
set smartindent

set textwidth=79    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.

"set mouse=a         " Enable the use of the mouse.

let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

"function FoldSpellBalloon()
"let foldStart = foldclosed(v:beval_lnum )
"let foldEnd = foldclosedend(v:beval_lnum)
"let lines = []
"" Detect if we are in a fold
"if foldStart < 0
"" Detect if we are on a misspelled word
" let lines = spellsuggest( spellbadword(v:beval_text)[ 0 ], 5, 0 )
"else
"" we are in a fold
" let numLines = foldEnd - foldStart + 1
"" if we have too many lines in fold, show only the first 14
"" and the last 14 lines
" if ( numLines > 31 )
"  let lines = getline( foldStart, foldStart + 14 )
"  let lines += [ '-- Snipped ' . ( numLines - 30 ) . ' lines --' ]
"  let lines += getline( foldEnd - 14, foldEnd )
" else
""less than 30 lines, lets show all of them
"  let lines = getline( foldStart, foldEnd )
" endif
"endif
"" return result
"return join( lines, has( "balloon_multiline" ) ? "\n" : " " )
"endfunction
runtime bundles/tplugin_vim/macros/tplugin.vim

:cabbrev t ConqueTerm
:cabbrev f NERDTree
:cabbrev te tabedit
vnoremap # :s#^#\# #<cr>
vnoremap -# :s#^\# ##<cr>

execute pathogen#infect()
syntax on
"filetype plugin indent on
Plugin 'gmarik/Vundle.vim'
"Plugin 'fatih/vim-go'
"Plugin 'LaTeX-Suite-aka-Vim-LaTeX'

Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'tpope/vim-fugitive'
"Bundle 'klen/python-mode'
"Plugin 'ervandew/supertab'

filetype plugin indent on    " required
set omnifunc=syntaxcomplete#Complete
