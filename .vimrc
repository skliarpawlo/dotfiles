execute pathogen#infect()
set nocompatible
filetype indent plugin on
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Bundle 'gmarik/Vundle.vim'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Bundle 'ap/vim-buftabline'
Bundle 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Bundle 'majutsushi/tagbar'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'davidhalter/jedi-vim'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-sensible'
Bundle 'solarnz/thrift.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'easymotion/vim-easymotion'
Bundle 'kevints/vim-aurora-syntax'
Bundle 'saltstack/salt-vim'
Bundle 'wikitopian/hardmode'
Bundle 'tpope/vim-dispatch'
Bundle 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Bundle 'junegunn/fzf.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'terryma/vim-expand-region'
Plugin 'christoomey/vim-tmux-navigator'
"Plugin 'vim-syntastic/syntastic'
Plugin 'sbdchd/neoformat'
Plugin 'luochen1990/rainbow'
call vundle#end()
filetype plugin indent on
source /Library/Python/2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
set guifont=Source\ Code\ Pro\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set laststatus=2
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8
set smartindent
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set expandtab
set ruler
set splitbelow
set splitright

set relativenumber
set number
syntax enable
set background=dark
let g:solarized_termcolors = 256  " New line!!
colorscheme solarized

set hlsearch
au BufWinEnter * let w:m1=matchadd('Search', '\%<101v.\%>97v', -1)
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
au BufRead,BufNewFile *.avdl setlocal filetype=avro-idl
set tags=~/.tubular-ctags;./tags;~/.ngfront-ctags;~/.ingestion-ctags;/
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END
autocmd BufWritePre * %s/\s\+$//e
" v expand
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" The Silver Searcher
if executable('ag')
   " Use ag over grep
   set grepprg=ag\ --nogroup\ --nocolor
endif

"save with Ctrl+S
noremap <silent> <leader>s :update<CR>
vnoremap <silent> <leader>s <C-C>:update<CR>
inoremap <silent> <leader>s <C-O>:update<CR>

"python formatter
let g:neoformat_python_autopep8 = {
            \ 'exe': 'autopep8',
            \ 'args': ['-s 4', '-E'],
            \ 'replace': 1,
            \ 'stdin': 1,
            \ 'no_append': 1,
            \ }

let g:neoformat_enabled_python = ['autopep8', 'yapf']

"jedi
let g:jedi#use_splits_not_buffers = "top"
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "0"

let mapleader = ","
nmap <leader>nt :NERDTree<cr>
nmap <leader>nf :NERDTreeFind<cr>
nmap <leader>c :Tags<cr>
nmap <leader>a :Ag<cr>
nmap <leader>j :GFiles?<cr>
nmap <leader>f :Files<cr>
nmap <leader>l :BLines<cr>
nmap <leader>t :TagbarToggle<cr>
nmap <leader>b :Buffers<cr>

"switch splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

vnoremap <leader>w :update<cr>
inoremap <leader>w :update<cr>
noremap <leader>w :update<cr>

vnoremap <leader>q :quit<cr>
inoremap <leader>q :quit<cr>
noremap <leader>q :quit<cr>

vnoremap <leader>s :sort<cr>
let NERDTreeIgnore = ['\.pyc$']
silent! call repeat#set("\<Plug>MyWonderfulMap",v:count)

"hardmode
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

"let g:syntastic_python_flake8_exec = 'python3'
"let g:syntastic_python_flake8_args = ['-m', 'flake8']

"rainbow parentheses
let g:rainbow_active = 0
noremap <leader>0 :RainbowToggle<cr>

set clipboard=unnamed
