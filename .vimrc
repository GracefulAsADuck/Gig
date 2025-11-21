" GENERAL ---------------------------------------------------------------- {{{

" Turn syntax highlighting on
syntax on

" Disable compatibility with vi which can cause unexpected issues.
" set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
" filetype plugin on

" Load an indent file for the detected file type.
" filetype indent on

set noswapfile

" Add numbers to each line on the left-hand side.
set number

" Highlight cursor line underneath the cursor horizontally.
" set cursorline

" Highlight cursor line underneath the cursor vertically.
" set cursorcolumn

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
" set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
" set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
" set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=500

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Set the window's title, reflecting the file currently being edited.
set title

" Use colors that suit a dark background.
set background=dark

" Show line number on the current line and relative numbers on all other lines.
set relativenumber

" Disable beep on errors.
set noerrorbells

"Flash the screen instead of beeping on errors.
set visualbell

" Always show cursor position
set ruler

" Folding
"setglobal foldopen-=block
"setglobal foldmethod=syntax
"setglobal foldlevelstart=5

" }}}


" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

""nnoremap – Allows you to map keys in normal mode.
""inoremap – Allows you to map keys in insert mode.
""vnoremap – Allows you to map keys in visual mode.

" Surround the visual selection in parenthesis/brackets/etc.:
"vnoremap $1 <esc>`>a)<esc>`<i(<esc>
""vnoremap $2 <esc>`>a]<esc>`<i[<esc>
""vnoremap $3 <esc>`>a}<esc>`<i{<esc>
""vnoremap $$ <esc>`>a"<esc>`<i"<esc>
""vnoremap $q <esc>`>a'<esc>`<i'<esc>"
"vnoremap $e <esc>`>a`<esc>`<i`<esc>

" Quickly insert parenthesis/brackets/etc.:

""inoremap $1 ()<esc>i
""inoremap $2 []<esc>i
""inoremap $3 {}<esc>i
""inoremap $4 {<esc>o}<esc>O
""inoremap $q ''<esc>i
""inoremap $e ""<esc>i
""inoremap $t <><esc>i

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O


" Set the backslash as the leader key.
" let mapleader = "\"

" Press \\ to jump back to the last cursor position.
" nnoremap <leader>\ ``

" Press \p to print the current file to the default printer from a Linux operating system.
" View available printers:   lpstat -v
" Set default printer:       lpoptions -d <printer_name>
" <silent> means do not display output.
""nnoremap <silent> <leader>p :%w !lp<CR>

" Type jj to exit insert mode quickly.
inoremap jj <Esc>

" Press the space bar to type the : character in command mode.
""nnoremap <space> :

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
""nnoremap o o<esc>
""nnoremap O O<esc>

" Center the cursor vertically when moving to the next word during a search.
""nnoremap n nzz
""nnoremap N Nzz

" Yank from cursor to the end of line.
""nnoremap Y y$

" Map the F5 key to run a Python script inside Vim.
" I map F5 to a chain of commands here.
" :w saves the file.
" <CR> (carriage return) is like pressing the enter key.
" !clear runs the external clear screen command.
" !python3 % executes the current file with Python.
""nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
""nnoremap <c-j> <c-w>j
""nnoremap <c-k> <c-w>k
""nnoremap <c-h> <c-w>h
""nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
""noremap <c-up> <c-w>+
""noremap <c-down> <c-w>-
""noremap <c-left> <c-w>>
""noremap <c-right> <c-w><

" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
""nnoremap <F3> :NERDTreeToggle<cr>

" Have nerdtree ignore certain files and directories.
""let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}

