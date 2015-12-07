" initial config
" cd && curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
" scp -r ~/Dropbox/setup/neovim/colors hpc:~/.vim/
" cd ~/.vim/bundle
" git clone https://github.com/bling/vim-airline
" git clone git://github.com/tpope/vim-fugitive.git

filetype plugin on

if exists('$ITERM_PROFILE')
  if exists('$TMUX') 
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end

" for tmux to automatically set paste and nopaste mode at the time pasting (as
" happens in VIM UI)

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'edkolev/promptline.vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Turn on syntax highlighting
syntax enable
" Select colorscheme
colorscheme cobalt
" Turn on line numbering
set number
" Enable transparent background
hi Normal ctermbg=none
" Configure airline
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
" Make mode swithcing faster
set timeoutlen=50
" let g:vim_markdown_folding_disabled=1
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" Markdown configuration
let g:markdown_fenced_languages = ['bash=sh', 'python', 'sql', 'R=r']
"let g:markdown_github_languages = ['bash=sh', 'python', 'sql', 'R=r']
" Always use clipboard rather then +/* registers
set clipboard+=unnamedplus
set wildmenu            " visual autocomplete for command menu
set cursorline          " highlight current line
set showmatch           " highlight matching [{()}]
set hlsearch            " highlight matches
set splitright          " vsplit on the right

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" incremental search
set incsearch
" backspace clears search
nmap <silent> <BS> :nohlsearch<CR>
" get rid of carets in airline
set fillchars+=stl:\ ,stlnc:\

nnoremap <Esc>h <C-w>h
nnoremap <Esc>j <C-w>j
nnoremap <Esc>k <C-w>k
nnoremap <Esc>l <C-w>l

" promptline config, x, y, z, warn in rprompt
let g:promptline_preset = {
        \'b'    : [ promptline#slices#user() ],
        \'z'    : [ promptline#slices#cwd({ 'dir_limit': 0 }) ],
        \'warn' : [ promptline#slices#last_exit_code() ],
        \'a'    : [ '%m' ],
        \'c'    : [ promptline#slices#git_status(), promptline#slices#vcs_branch() ]}

let g:promptline_theme = {
        \'a'    : [188, 234],
        \'b'    : [231, 240],
        \'c'    : [188, 234],
	\'x'    : [188, 234],
        \'y'    : [231, 240],
        \'z'    : [188, 234],
        \'warn' : [232, 166]}

