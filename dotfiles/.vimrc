" vim:fenc=utf-8:nu:ai:si:ts=2:sw=2:fdm=marker:
" plugins/colorschemes used {{{1
" secure modelines:      http://github.com/ciaranm/securemodelines
" calendar:              http://www.vim.org/scripts/script.php?script_id=52
" cmdline complete:      http://www.vim.org/scripts/script.php?script_id=2222
" comments:              http://www.vim.org/scripts/script.php?script_id=1528
" uptime:                http://www.vim.org/scripts/script.php?script_id=965
" colemak.vim:           http://colemak.com/pub/vim/colemak.vim
" pyte.vim:              http://www.vim.org/scripts/script.php?script_id=1492
" nerdtree.vim:          http://www.vim.org/scripts/script.php?script_id=1658

" modelines (secure modelines plugin req.) {{{1
" disable internal modelines parser
set modelines=0
let g:secure_modelines_verbose=0       " securemodelines vimscript
let g:secure_modelines_modelines = 15  " 15 available modelines

" general settings {{{
set nocompatible      " disable vi compatibility
set shiftwidth=2      " number of spaces to indent
set tabstop=2         " number of spaces <TAB> counts for
set textwidth=78      " line length before wrapping
set wrap              " Wrap a line if its too long
set number            " show line numbers
set incsearch         " incremental searching
set ignorecase        " search ignoring case
set hlsearch          " highlight searches
set showmatch         " show matching brackets
set showmode          " show current mode
set ruler             " show position of cursor
set title             " show title in console status bar
set noautoindent      " don't autoindent code
set nosmartindent
set cmdheight=1       " commandbar height
set nolinebreak       " break line at word
set nostartofline     " remember the cursor position
set scrolloff=10      " keep 10 lines for scope

" folding {{{1
set foldmethod=marker " fdm
let g:sh_fold_enabled=1
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" colorscheme (pyte  colorscheme req) {{{1
if (&term =~ 'linux')
	set t_Co=16
	set termencoding=utf-8
	colorscheme desert
else
	set t_Co=256
	colorscheme pyte
	set termencoding=utf-8
endif

" syntax-highlighting {{{1
if has ("syntax")
	syntax on  " syntax-highlighting
endif


" backup {{{1
set backup               " create a backup file
set backupdir=~/.backup  " backup directory
set history=200          " history to remember

" statusline {{{1
set laststatus=2                " always show the statusline

" format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
	let curdir = substitute(getcwd(), '/home/uh', "~", "g")
	return curdir
endfunction

function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	else
		return ''
	endif
endfunction

" NERD Tree Plugin Settings {{{1
nmap <F7> :NERDTreeToggle<CR>   " toggle the NERDtree with F7
nmap <S-F7> :NERDTreeClose<CR>  " close the NERDtree with Shift-F7


" searches, indent display, calendar and finally source colemak {{{1
if has ("autocmd")
	au VimEnter * nohls  " turn off any existing searches
endif

set list
set lcs=tab:│┈,extends:>,precedes:<,nbsp:&  " display <tab>s

let g:calendar_monday = 1  " calendar starts with monday

source /usr/share/vim/vimfiles/keymap/colemak.vim  " colemak.vim
