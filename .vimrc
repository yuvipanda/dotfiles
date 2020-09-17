set nocompatible               " be iMproved
filetype off                   " required!
set shell=/bin/bash            " otherwise it tries to use fish

filetype plugin indent on     " required!

set hidden              " Allow more than one buffer open at a time
set autoindent      " Copy current indent level to newline
set smartindent     " Smart indent / oudent based on context (extra indent level after a if (...) { for example
set incsearch       " Search as you type
set nohlsearch      " Do not highlight all search results
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab       " Fuck hard tabs
set autoread
set history=1000
set synmaxcol=400
set ignorecase
set smartcase
set title
set gdefault
set relativenumber  " Number lines relatively based on diff from current location.
set cursorline      " Highlight line cursor is currently on
set laststatus=2
set wildmenu
set wildmode=list:longest
set showmatch       " Automatically highlight matching braces


" When you open a file as normal user but need to sudo to write to it
cmap w!! w !sudo tee % >/dev/null

let mapleader=","   " Much easier to hit than /

"fix regex searching
nnoremap / /\v
vnoremap / /\v

nnoremap ; :        " Much easier to hit than shift+:

"visual line movements - makes working with wrapped lines easier
:map j gj
:map k gk
:map ' `

"autosave on lost focus
:au FocusLost * silent! wa

" Shortcut to reformat entire file
:nmap <Leader>F mxgg=G`x


nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async<cr>
"nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
nnoremap <leader>/ :<C-u>Unite -buffer-name=search grep:.<cr>

"Kill runaway fugitives
autocmd BufReadPost fugitive://* set bufhidden=delete

"Twitter shortcuts
"nnoremap <leader>mp :PosttoTwitter<CR>
"nnoremap <leader>mm :MentionsTwitter<CR>

set exrc
set secure

if has("gui_running")
	set guifont=Monaco:h16
	:colorscheme distinguished
	set background=dark
	set guioptions-=T
	set guioptions-=m
else
	set t_Co=256 "Ensure 256 colors
endif

" No more littering
set backup
set backupdir=~/.vimruntime/backup
set directory=~/.vimruntime/temp

" Undo across file closes
set undofile
set undodir=~/.vimruntime/undodir
set undolevels=1000
set undoreload=10000

"Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

"BufClose aliasing. I wanted :bc but apparently that's a no go (or more
"probably, I just don't know enough vim scripting)
nnoremap <leader>wk :BufClose<CR>
nnoremap <leader>wd :bd<CR>

" Shortcut for search/replace
nnoremap <Leader>gs :perldo s//g<left><left>

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Set list should show individual characters
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Rainbow!
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadSquare
nnoremap <leader>R :RainbowParenthesesToggle<CR>

let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['html', 'javascript', 'java', 'eruby'] }

" Jedi!
" Turn off docstring automatically popping up
autocmd FileType python setlocal completeopt-=preview
