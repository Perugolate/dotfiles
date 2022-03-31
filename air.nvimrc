"vim-plug instructions----------------
"Install plugins：:PlugInstall
"Update plugins：:PlugUpdate
"Remove plugins：:PlugClean (" first)
"Check the plugin status：:PlugStatus
"Upgrade vim-plug itself：:PlugUpgrade
""Plug Ins start----------------------
call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'edkolev/promptline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kassio/neoterm'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'
"Plug 'plasticboy/vim-markdown'
" Plug 'jalvesaq/Nvim-R'
call plug#end()
"Plug Ins end------------------------

" let g:vim_markdown_folding_disabled=1
"autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Markdown configuration-------------
" currently using tpope markdown highlighting that ships with vim 
" vim-pandoc-syntax is also installed as dep for vim-rmarkdown
"let g:markdown_fenced_languages = ['sh', 'python', 'sql', 'R=r', 'awk']
" turn off fence concealment by vim-pandoc-syntax
let g:pandoc#syntax#conceal#use = 1
let g:pandoc#syntax#codeblocks#embeds#langs = ["R=r", "bash=sh"]

" Enable transparent background, needed on mac/iterm2?
hi Normal ctermbg=none
" Select colorscheme
colorscheme cobalt
" colorscheme base16-eighties

let g:airline_powerline_fonts = 1

set clipboard+=unnamedplus   " use clipboard rather then +/* registers
set number                   " turn on line numbering
"set timeoutlen=50            " make mode swithcing faster
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

" testing neovim mappings
"nnoremap <c-c><c-c> :TREPLSendLine
"nnoremap <c-c><c-c> :TREPLSendLine<CR>
nnoremap <SPACE> <Nop>
let mapleader=" "
" update: this is a problem
" it remaps delete line and insert 
" nnoremap <C-s> :TREPLSendLine<CR>
" vnoremap <C-s> :TREPLSendSelection<CR>
let g:neoterm_default_mod = 'vertical'
nnoremap , :TREPLSendLine<CR>
vnoremap , :TREPLSendSelection<CR>

" promptline config---------------------------
" in combination with ~/.zshrc prompts:
" PS1='%n@%m:$ '
" RPROMPT='%~'
" for changes to take effect run:
" :PromptlineSnapshot ~/.promptline.sh
" append theme is desired:
" :PromptlineSnapshot ~/.promptline.sh airline
" the file is then sourced, e.g. in ~/.zshrc
" source ~/.promptline.sh

let g:promptline_preset = {
        \'b'    : [ promptline#slices#user() ],
        \'z'    : [ promptline#slices#cwd({ 'dir_limit': 4 }) ],
        \'warn' : [ promptline#slices#last_exit_code() ],
        \'a'    : [ '%m' ],
	\'c'    : [ promptline#slices#git_status(), promptline#slices#python_virtualenv() ]}

let g:promptline_theme = {
        \'a'    : [188, 234],
        \'b'    : [231, 240],
        \'c'    : [188, 234],
	\'x'    : [188, 234],
        \'y'    : [231, 240],
        \'z'    : [188, 234],
        \'warn' : [232, 166]}
"end promptline config------------------------

"coc config-----------------------------------
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"coc config end-------------------------------
" use <tab> for trigger completion and navigate to the next complete item
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~ '\s'
"endfunction
"
"inoremap <silent><expr> <Tab>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<Tab>" :
"      \ coc#refresh()
"
"played around with the config a lot 
"for now, try autoomplete remapped to tab
"this keeps enter for new lines and prevents
"accidentally completion when begininning a newline
"cycle through completions with C-n and C-p
"inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
"inoremap <silent><expr> <cr> "\<c-g>u\<CR>"
"end coc config--------------------------------

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

highlight clear SignColumn " git gutter same color as background

" Send RMarkdown code chunk.
" taken from https://github.com/daler/dotfiles
" When inside a code chunk, <Leader>cd selects the chunk and sends to neoterm.
" Breaking this down...
"
" /```{<CR>                       -> search for chunk delimiter (recall <CR> is Enter)
" N                               -> find the *previous* match to ```{
" j                               -> move down one line from the previous match
" V                               -> enter visual line-select mode
" /^```\n<CR>                     -> select until the next chunk delimiter by itself on the line (which should be the end)
" k                               -> go up one line from that match so we don't include that line
" <Plug>(neoterm-repl-send)<CR>   -> send the selection to the neoterm terminal
" /```{r<CR>                      -> go to the start of the next chunk
nmap <Leader>cd /```{<CR>NjV/```\n<CR>k<Plug>(neoterm-repl-send)<CR>/```{r<CR>
" default timeout length seems to be too short for me to use the above mapping
" had to comment this out again because it slowed down neoterm send too much
"set timeout timeoutlen=3000 ttimeoutlen=100
let g:pandoc#spell#enabled = 0

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

