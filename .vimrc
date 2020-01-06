if &compatible
  set nocompatible
endif

" ----------- "
" dein config "
" ----------- "
" The dir which dein is installed
let s:dein_dir = expand('~/.vim/plugins/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" Install dein from github if not exist
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" Start configuration
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
" The list of toml file
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
" Read toml and cache it
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
" End configuration
  call dein#end()
  call dein#save_state()
endif

" Install if there are plugins not installed
if dein#check_install()
  call dein#install()
endif
" --------------- "
" end dein config "
" --------------- "

" ----------- "
" comment out "
" ----------- "
nmap ,c<Space> <Plug>(caw:zeropos:toggle)
vmap ,c<Space> <Plug>(caw:zeropos:toggle)
" --------------- "
" end comment out "
" --------------- "


" ---- "
" beep "
" ---- "
set visualbell t_vb=

exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview

syntax on

set cursorline
hi cursorline term=reverse cterm=none ctermbg=232 ctermfg=NONE
hi Cursor guifg=black ctermfg=black ctermbg=black
hi Comment ctermfg=27

augroup cch
autocmd! cch
 autocmd WinLeave * set nocursorline
 autocmd WinEnter,BufRead * set cursorline
augroup END

autocmd BufWritePre * :%s/\s\+$//ge

set enc=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp
"set fencs=iso-2022-jp,euc-jp,cp932
set ambiwidth=double

set ignorecase
set wrapscan
set incsearch
set hlsearch

set autoindent
set cindent
set tabstop=4
set shiftwidth=4
set expandtab
set nopaste

set number
set ruler
set nolist
set noshowmatch
let loaded_matchparen = 1
set wrap
set title
set showcmd
set cmdheight=2
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}
set wildmenu
set fileformats=unix,dos,mac

set backspace=2
set scrolloff=5
set formatoptions+=mM
let format_join_spaces = 4
let format_allow_over_tw = 1
set nobackup
set history=1000
set mouse=i

set iminsert=0
set imsearch=0
set imdisable
set iminsert=1
set imsearch=1

filetype plugin indent on
highlight Search term=reverse ctermbg=DarkBlue ctermfg=NONE
autocmd FileType ruby set tabstop=2 tw=0 sw=2 expandtab
autocmd FileType eruby set tabstop=2 tw=0 sw=2 expandtab
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 smarttab expandtab shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead app/*/*.rhtml set ft=mason fenc=utf-8
autocmd BufNewFile,BufRead app/**/*.rb set ft=ruby fenc=utf-8
autocmd BufNewFile,BufRead app/**/*.yml set ft=ruby fenc=utf-8
autocmd BufNewFile,BufRead config.ru set ft=ruby fenc=utf-8
autocmd BufNewFile,BufRead *.cap set ft=ruby fenc=utf-8
autocmd BufNewFile,BufRead *.rabl set ft=ruby fenc=utf-8
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
autocmd FileType c hi Comment ctermfg=darkcyan
autocmd FileType cpp hi Comment ctermfg=darkcyan
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et
autocmd FileType js set tabstop=4 tw=0 sw=4 expandtab

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

au FileType go setlocal sw=4 ts=4 sts=4 noet
au FileType go setlocal makeprg=go\ build\ ./... errorformat=%f:%l:\ %m
au BufWritePre *.go Fmt

source ~/.vimrc.keymap
" Enter always means inserting line
nnoremap <S-Enter> O<ESC>
nnoremap <Enter> o<ESC>

nnoremap <Space>.  :<C-u>edit $MYVIMRC<CR>
nnoremap <Space>,  :<C-u>source $MYVIMRC<CR>

nnoremap <silent><C-e> :NERDTreeToggle<CR>

" default key-bind of opening comamnd-line window makes typo frequently.
" " So, using qqq prefix for those.
nnoremap qqq: <Esc>q:
nnoremap qqq/ <Esc>q/
nnoremap qqq? <Esc>q?
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>


" NERD Commenter
let NERDSpaceDelims = 1
let NERDShutUp = 1
let mapleader = ','

" scheme setting
au Filetype scheme nmap <C-p> :!gosh %

"  quick run option
command -nargs=* Qr QuickRun
let g:quickrun_config = {
\  "_" : {
\    "outputter/buffer/split" : "botright 8sp",
\  }
\}

"  set vimfiler as default explorer
let g:vimfiler_as_default_explorer = 1
nmap <C-v><C-f> :VimFiler -split -simple -winwidth=35 -no-quit<CR>
