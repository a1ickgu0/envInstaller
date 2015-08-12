" color theme download: http://www.cs.cmu.edu/~maverick/VimColorSchemeTest/index-c.html
color darkZ
syntax enable
syntax on

highlight Tabs ctermbg=1
highlight Cursor guifg=red guibg=black

match Tabs "\t"

set nocompatible
set bsdir=buffer
set autochdir
set nu!
set nuw=1
set ruler
set hlsearch
set tabstop=4
set smartindent

set cindent shiftwidth=4
set cinoptions +=:0,l4
set comments=://
set comments=s1:/*,mb:*,ex0:/
set fileformats=unix,dos
set cmdheight=1
set nobackup
set shortmess=atI
set noerrorbells
set incsearch
set list
set lcs=tab:>-
set fileencoding=gbk
set fileencodings=ucs-bom,gbk,utf-8,default
set foldmethod=marker

" Tag list (ctags)
" http://vim.sourceforge.net/scripts/script.php?script_id=273
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Auto_Open = 0
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_Menu = 1

let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWidth = 40

filetype plugin indent on
set completeopt=longest,menu
set csprg=/usr/bin/cscope

" enhance tag search
set tags=./tags,./../tags,./**/tags

" echofun.vim
" script update:http://www.vim.org/scripts/script.php?script_id=1736

" bufexplorer.vim
" script update:http://www.vim.org/scripts/script.php?script_id=42
let g:bufExplorerShowDirectories=1
let g:bufExplorerShowRelativePath=1

" supertab.vim
" script update:http://www.vim.org/scripts/script.php?script_id=182
let mapleader = ","

" mark.vim
" http://www.vim.org/scripts/script.php?script_id=1238

" srcexpl.vim
" http://www.vim.org/scripts/script.php?script_id=2179
" Set the refreshing time interval, such as 2 seconds
let g:SrcExpl_RefreshTime   = 2
" Initialize the height of the Source Explorer window
let g:SrcExpl_WinHeight     = 12
" Make your own map key to force to do a refreshing
let g:SrcExpl_RefreshMapKey = "<Space>"
" Make your own map key for 'SrcExplGoBack' operation
let g:SrcExpl_GoBackMapKey  = "<C-b>"
" Doxygen Configure 
let g:DoxygenToolkit_paramTag_pre="@Param " 
let g:DoxygenToolkit_returnTag="@Returns   " 
let g:DoxygenToolkit_authorName="Alick" 
let g:DoxygenToolkit_licenseTag="My own license"

" Key mapping
nmap <silent> wm :WMToggle<CR>
nmap <silent> wb :BufExplorer<CR>

" iabbrev functions defins
fun! Eatchar(pat)
    let s:c = nr2char(getchar())
    return (s:c =~ a:pat) ? '' : s:c
endfun
fun! <SID>iabbrev_lang_c()
    iabbrev <buffer> #i #include <>/<LEFT>
    iabbrev <buffer> #d #define
endfun

" Fast reloading of the .vimrc
map <silent> <leader>sc :source ~/.vimrc<cr>
" Fast editing of .vimrc
map <silent> <leader>ec :e ~/.vimrc<cr>

" session configure
set path=.
map <silent> <leader>mm :mksession! wk.vim<cr>
if filereadable("wk.vim")
    source wk.vim
endif

" ============================================================================================
" cscope config
if filereadable("cscope.out")
    cs add cscope.out
endif
if has('cscope')
	set cscopetag cscopeverbose
	if has('quickfix')
		set cscopequickfix=s-,c-,d-,i-,t-,e-
	endif
	cnoreabbrev csa cs add
	cnoreabbrev csf cs find
	cnoreabbrev csk cs kill
	cnoreabbrev csr cs reset
	cnoreabbrev css cs show
	cnoreabbrev csh cs help
	command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
	nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" Lookupfile
let g:LookupFile_MinPatLength = 2
let g:LookupFile_PreserveLastPattern = 0
let g:LookupFile_PreservePatternHistory = 1
let g:LookupFile_AlwaysAcceptFirst = 1
let g:LookupFile_AllowNewFiles = 0

if filereadable("./filenametags")
	let g:LookupFile_TagExpr = '"./filenametags"'
endif

nmap <leader>o :LUTags<CR>
nmap <leader>b :LUBufs<CR>
nmap <leader>t :LUWalk<CR>

autocmd FileType php set expandtab
autocmd FileType c,cpp set expandtab

autocmd FileType c,cpp nmap <silent> wt  :tselect<CR>
autocmd FileType c,cpp nmap <silent> wtr :tprevious<CR>
autocmd FileType c,cpp nmap <silent> wtn :tnext <CR>

autocmd FileType c,cpp nmap <s-left> <C-W><
autocmd FileType c,cpp nmap <s-right> <C-W>>
autocmd FileType c,cpp nmap <s-up> <C-W>+
autocmd FileType c,cpp nmap <s-down> <C-W>-
autocmd FileType c,cpp: call <SID>iabbrev_lang_c()

" Function Key remap
autocmd FileType c,cpp nmap <F2> :clist<CR>
autocmd FileType c,cpp nmap <F3> :cprev<CR>
autocmd FileType c,cpp nmap <F4> :cnext<CR>
autocmd FileType c,cpp nmap <F7> :LUTags<CR>
autocmd FileType c,cpp nmap <F10> :SrcExplToggle<CR>

" tools configure
"
if exists('$TMUX')
	set term=screen-256color
endif

" Static cursor shape
if exists('$ITERM_PROFILE')
	if exists('$TMUX') 
		let &t_SI = "\<Esc>[3 q"
		let &t_EI = "\<Esc>[0 q"
	else
		let &t_SI = "\<Esc>]50;CursorShape=1\x7"
		let &t_EI = "\<Esc>]50;CursorShape=0\x7"
	endif
end

