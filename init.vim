"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/pauljohnston/.local/share/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/pauljohnston/.local/share/dein')

" Let dein manage dein
" Required:
call dein#add('/Users/pauljohnston/.local/share/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('bling/vim-airline')
call dein#add('tpope/vim-fugitive')
call dein#add('edkolev/promptline.vim')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

" let g:vim_markdown_folding_disabled=1
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" Markdown configuration
let g:markdown_fenced_languages = ['sh', 'python', 'sql', 'R=r', 'awk']

" Enable transparent background
hi Normal ctermbg=none

set clipboard+=unnamedplus   " use clipboard rather then +/* registers
set number                   " turn on line numbering
set timeoutlen=50            " make mode swithcing faster
set wildmenu                 " visual autocomplete for command menu
" set cursorline               " highlight current line
set showmatch                " highlight matching [{()}]
set hlsearch                 " highlight matches
set splitright               " vsplit on the right
set inccommand=nosplit       " turn on live substitution

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" incremental search
set incsearch
" backspace clears search
nmap <silent> <BS> :nohlsearch<CR>
" get rid of carets in airline
set fillchars+=stl:\ ,stlnc:\

" if neovim then map quick terminal/window navigation, and terminal mode exit
" if neovim also fix terminal mode Alt+b and Alt+f line navigation and Alt+.
" for last argument
" if vim then map window navigation only
if exists(':tnoremap')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
  tnoremap <A-b> <Esc>b
  tnoremap <A-f> <Esc>f
  tnoremap <A-.> <Esc>.
  nnoremap <A-h> <C-w>h
  nnoremap <A-j> <C-w>j
  nnoremap <A-k> <C-w>k
  nnoremap <A-l> <C-w>l
else
  nnoremap <Esc>h <C-w>h
  nnoremap <Esc>j <C-w>j
  nnoremap <Esc>k <C-w>k
  nnoremap <Esc>l <C-w>l
endif

" get rid of line numbers after opening terminal in a split
autocmd TermOpen * set nonumber

" Use tab and shift-tab to cycle through windows.
nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W


