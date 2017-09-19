" color theme download: http://www.cs.cmu.edu/~maverick/VimColorSchemeTest/index-c.html

" General "{{{
color darkZ
set nocompatible
set bsdir=buffer
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
set path=.
set completeopt=longest,menu
set csprg=/usr/bin/cscope

" enhance tag search
set tags=./tags,./../tags,./**/tags


let mapleader = ","

syntax enable
syntax on
highlight Tabs ctermbg=1
highlight Cursor guifg=red guibg=black

match Tabs "\t"

" Auto Filetype Setting
autocmd FileType php set expandtab
autocmd FileType c,cpp set expandtab

"}}}

" Vundle "{{{
" Vundle command
" 		From Vim command line :PluginInstall
" 		From Shell command: vim +PluginInstall +qall
"
" Vundle configure
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Vundle manage
Plugin 'VundleVim/Vundle.vim'

" My Bundle List
"  1. vim-scripts repos: repo_name
"     https://github.com/vim-scripts
Plugin 'genutils'
Plugin 'taglist.vim'
Plugin 'lookupfile'
Plugin 'cscope_macros.vim'
Plugin 'SrcExpl'
Plugin 'SuperTab'
Plugin 'Mark'
"Plugin 'gtags-cscope.vim'

"  2. original repos from github: username/repo_name
Plugin 't9md/vim-quickhl'

"  3. custom repos
Plugin 'bufexplorer.zip'
Plugin 'winmanager'

call vundle#end()

filetype plugin indent on

" Vundle End
" ===========================================================================
""}}}


" Plugin taglist
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Auto_Open = 0
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_Menu = 1

" lookupfile


" Plugin winmanager
let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWidth = 40

" Plugin bufexplorer
let g:bufExplorerShowDirectories=1
let g:bufExplorerShowRelativePath=1

" SrcExpl
let g:SrcExpl_RefreshTime   = 2 			" Set the refreshing time interval, such as 2 seconds
let g:SrcExpl_WinHeight     = 12 			" Initialize the height of the Source Explorer window
let g:SrcExpl_RefreshMapKey = "<Space>" 	" Make your own map key to force to do a refreshing
let g:SrcExpl_GoBackMapKey  = "<C-b>" 		" Make your own map key for 'SrcExplGoBack' operation
let g:SrcExpl_pluginList = [
        \ "__Tag_List__",
        \ "_NERD_tree_"
    \ ]
let g:SrcExpl_searchLocalDef = 1 			" Enable Local Search
let g:SrcExpl_isUpdateTags = 0 				" Do not let the Source Explorer update the tags file when opening
" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
" // create/update the tags file
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."
" // Set "<F12>" key for updating the tags file artificially
let g:SrcExpl_updateTagsKey = "<F12>"
" // Set "<F3>" key for displaying the previous definition in the jump list
let g:SrcExpl_prevDefKey = "<F3>"
" // Set "<F4>" key for displaying the next definition in the jump list
let g:SrcExpl_nextDefKey = "<F4>"

" Doxygen Configure
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_authorName="Alick"
let g:DoxygenToolkit_licenseTag="My own license"


" ============================================================================================
" cscope config
"if filereadable("cscope.out")
"    cs add cscope.out
"endif

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
endif

" Lookupfile
let g:LookupFile_MinPatLength = 4
let g:LookupFile_PreserveLastPattern = 0
let g:LookupFile_PreservePatternHistory = 1
let g:LookupFile_AlwaysAcceptFirst = 1
let g:LookupFile_AllowNewFiles = 0

if filereadable("./filenametags")
	let g:LookupFile_TagExpr = '"./filenametags"'
endif

" Key mapping "{{{
" Fast reloading of the .vimrc
map <silent> <leader>sc :source ~/.vimrc<cr>
" Fast editing of .vimrc
map <silent> <leader>ec :e ~/.vimrc<cr>
" session configure
map <silent> <leader>mm :mksession! wk.vim<cr>
" LookupFile
nmap <F7> :LookupFile<CR>

" File Type mapping "{{{
autocmd FileType c,cpp nmap <silent> wt  :tselect<CR>
autocmd FileType c,cpp nmap <silent> wtr :tprevious<CR>
autocmd FileType c,cpp nmap <silent> wtn :tnext <CR>
autocmd FileType c,cpp nmap <s-left> <C-W><
autocmd FileType c,cpp nmap <s-right> <C-W>>
autocmd FileType c,cpp nmap <s-up> <C-W>+
autocmd FileType c,cpp nmap <s-down> <C-W>-

" Function Key remap
autocmd FileType c,cpp nmap <F10> :SrcExplToggle<CR>

" Cscope
if has('cscope')
	autocmd FileType c,cpp nmap <C-2>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	autocmd FileType c,cpp nmap <C-2>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	autocmd FileType c,cpp nmap <C-2>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	autocmd FileType c,cpp nmap <C-2>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	autocmd FileType c,cpp nmap <C-2>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	autocmd FileType c,cpp nmap <C-2>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	autocmd FileType c,cpp nmap <C-2>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	autocmd FileType c,cpp nmap <C-2>d :cs find d <C-R>=expand("<cword>")<CR><CR>
	autocmd FileType c,cpp nmap <C-p> :cprev <C-R> <CR><CR>
	autocmd FileType c,cpp nmap <C-n> :cnext <C-R> <CR><CR>
endif
""}}} /// End File Type mapping

" Plugin command mapping "{{{
" Plugin Winmanager
nmap <silent> wm :WMToggle<CR>
" Plugin bufexplorer
nmap <silent> wb :BufExplorer<CR>
" Plugin Lookupfile
nmap <leader>o :LUTags<CR>
nmap <leader>b :LUBufs<CR>
nmap <leader>t :LUWalk<CR>

""}}} /// End Plugin command mapping

""}}} /// End Keymapping

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

" Vim session file
if filereadable("wk.vim")
    source wk.vim
endif
