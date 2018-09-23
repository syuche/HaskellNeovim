"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim
" Required:
if dein#load_state($HOME . '/.config/nvim/dein')

  " XDG base direcory compartible
  let g:dein#cache_directory = $HOME . '/.cache/dein'

  " dein begin
  call dein#begin($HOME . '/.config/nvim/dein')

 " プラグインリストを収めた TOML ファイル
 " 予め TOML ファイルを用意しておく
 let s:toml_dir  = $HOME . '/.config/nvim/dein/toml' 
 let s:toml      = s:toml_dir . '/dein.toml'
" let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'

 " TOML を読み込み、キャッシュしておく
 call dein#load_toml(s:toml,      {'lazy': 0})
" call dein#load_toml(s:lazy_toml, {'lazy': 1})


  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------


set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set number

set guifont=Ricty:h14

set showtabline=2

set termguicolors

colorscheme desert

let g:python3_host_prog = '/usr/bin/python3.6'
