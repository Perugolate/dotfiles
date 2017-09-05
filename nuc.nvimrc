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

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/paul/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/paul/.vim/bundles')
  call dein#begin('/home/paul/.vim/bundles')

  " Let dein manage dein
  " Required:
  call dein#add('/home/paul/.vim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('bling/vim-airline')
  call dein#add('tpope/vim-fugitive')
  call dein#add('edkolev/promptline.vim')
  call dein#add('hkupty/iron.nvim')

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

filetype plugin indent on
syntax enable

" Required:
filetype plugin indent on

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
let g:markdown_fenced_languages = ['sh', 'python', 'sql', 'R=r', 'awk', 'perl6', 'perl']
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

" neovim update introduces folds where I don't want them so:
set nofoldenable
" turn on live substitution
set inccommand=nosplit
" get rid of `q` in command prompt see https://github.com/neovim/neovim/issues/7049
set guicursor=
" get rid of line numbers after opening terminal in a split
autocmd TermOpen * set nonumber

" iron.nvim
map <silent> <Plug>(iron-send-motion) 
      \ :<c-u>let b:iron_cursor_pos = winsaveview() \| set opfunc=IronSendMotion<CR>g@
vmap <silent> <Plug>(iron-send-motion)
      \ :<c-u>let b:iron_cursor_pos = winsaveview() \| call IronSendMotion('visual')<CR>

"Call previous command again
map <silent> <Plug>(iron-repeat-cmd) :call IronSend("\u001b\u005b\u0041")<CR>
map <silent> <Plug>(iron-cr)         :call IronSend("")<CR>                   " <CR> to force execution of command
map <silent> <Plug>(iron-interrupt)  :call IronSend("\u0003")<CR>             " <c-c> to interrupt command
map <silent> <Plug>(iron-exit)       :call IronSend("\u0004")<CR>             " <c-d> to exit iron
map <silent> <Plug>(iron-clear)      :call IronSend("\u000C")<CR>             " <c-l> to clear screen

if !exists('g:iron_map_defaults')
  let g:iron_map_defaults = 1
endif

if g:iron_map_defaults
    nmap ctr <Plug>(iron-send-motion)
    vmap ctr <Plug>(iron-send-motion)
    nmap cp <Plug>(iron-repeat-cmd)
endif

function! IronWatchFile(fname, command) abort
  augroup IronWatch
    exec "autocmd BufWritePost ".a:fname." call IronSend('".a:command."')"
  augroup END
endfunction

function! IronUnwatchFile(fname) abort
  exec "autocmd! IronWatch BufWritePost " . a:fname
endfunction

command! -nargs=* IronWatchCurrentFile call IronWatchFile(expand('%'), <q-args>)
command! -nargs=* IronUnwatchCurrentFile call IronUnwatchFile(expand('%'))

