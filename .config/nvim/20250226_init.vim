let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"vim-plug instructions----------------
"Install plugins：:PlugInstall
"Update plugins：:PlugUpdate
"Remove plugins：:PlugClean (" first)
"Check the plugin status：:PlugStatus
"Upgrade vim-plug itself：:PlugUpgrade
""Plug Ins start----------------------
call plug#begin('~/.vim/plugged')
"Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
"Plug 'edkolev/promptline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kassio/neoterm'
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'vim-pandoc/vim-pandoc-syntax'
"Plug 'vim-pandoc/vim-rmarkdown'
"Plug 'snakemake/snakemake', {'rtp': 'misc/vim'}
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'snakemake/snakefmt'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'stevearc/oil.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
"Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-copilot'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'folke/trouble.nvim'
"Plug 'dense-analysis/ale'
" Plug 'amarakon/nvim-lua-script'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'R-nvim/R.nvim'
" Plug 'tpope/vim-surround'
" Plug 'plasticboy/vim-markdown'
" Plug 'jalvesaq/Nvim-R'
call plug#end()
"Plug Ins end------------------------

" Enable transparent background, needed on mac/iterm2?
hi Normal ctermbg=none
" Select colorscheme
colorscheme catppuccin-mocha
" colorscheme cobalt
" colorscheme base16-eighties
"autocmd vimenter * ++nested colorscheme gruvbox
let g:airline_powerline_fonts = 1

" set guicursor=
" autocmd OptionSet guicursor noautocmd set guicursor=
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
" set the neoterm python repl
" --no-autoindent was necessary before implementation of bracketed paste
"let g:neoterm_repl_python = 'ipython --no-autoindent'
"let g:neoterm_repl_python = 'ipython' 
"let g:neoterm_bracketed_paste = 1
" had to turn off bracketed paste as it breaks :TREPLSendLine in R
" use paste magic instead of the exec command (can't remember why though)
" presumably to handle the pasting of indented code
let g:neoterm_repl_ipython_magic = 1
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

"let g:promptline_preset = {
"        \'b'    : [ promptline#slices#user() ],
"        \'z'    : [ promptline#slices#cwd({ 'dir_limit': 4 }) ],
"        \'warn' : [ promptline#slices#last_exit_code() ],
"        \'a'    : [ '%m' ],
"	\'c'    : [ promptline#slices#git_status(), promptline#slices#conda_env() ],
"        \'y'    : [ promptline#slices#vcs_branch() ]}
"let g:promptline_theme = {
"        \'a'    : [188, 234],
"        \'b'    : [231, 240],
"        \'c'    : [188, 234],
"	\'x'    : [188, 234],
"        \'y'    : [231, 240],
"        \'z'    : [188, 234],
"        \'warn' : [232, 166]}
""end promptline config------------------------

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
"""""inoremap <silent><expr> <TAB>
"""""      \ pumvisible() ? "\<C-n>" :
"""""      \ <SID>check_back_space() ? "\<TAB>" :
"""""      \ coc#refresh()
"""""inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"""""
"""""function! s:check_back_space() abort
"""""  let col = col('.') - 1
"""""  return !col || getline('.')[col - 1]  =~# '\s'
"""""endfunction
"""""
"""""" Use <c-space> to trigger completion.
"""""inoremap <silent><expr> <c-space> coc#refresh()
"""""
"""""" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
"""""" position. Coc only does snippet and additional edit on confirm.
"""""" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
"""""if exists('*complete_info')
"""""  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"""""else
"""""  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"""""endif
"""""
"""""highlight clear SignColumn " git gutter same color as background

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
""""let g:pandoc#spell#enabled = 0

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

" fzf.vim shortcut for :Files
" it is a hangover from ctrlp.vim
" look at https://vim.fandom.com/wiki/Unused_keys
" consider shortcuts for :Buffers etc
nnoremap <C-p> :Files<Cr>
" Jump to open buffer
let g:fzf_buffers_jump = 1

" disable arrows for time being
" note this also disables scrolling
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>


set nofoldenable
nnoremap <silent> ca <cmd>lua vim.lsp.buf.code_action()<CR>
"""let g:pandoc#syntax#conceal#use = 1
"""let g:pandoc#syntax#codeblocks#embeds#langs = ["R=r", "bash=sh", "vim", "python"]
lua << END
vim.api.nvim_command("highlight! TermCursorNC guifg=NONE guibg=NONE")
require('lualine').setup {
    options = {
        theme = "catppuccin"
    }
}
require("oil").setup()
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "csv", "bash", "groovy", "latex", "lua", "luadoc", "markdown", "markdown_inline", "python", "r", "rnoweb", "snakemake", "ssh_config", "tsv", "vim", "vimdoc", "yaml" },
  highlight = { enable = true },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
require('lspconfig').r_language_server.setup{
    cmd = { "/Users/paul/mambaforge/envs/glmgampoi/bin/R", "--slave", "-e", "languageserver::run()" },
    filetypes = { "r", "R", "rmd", "Rmd" },
    -- Change root_dir to work in any directory containing R files
}
local cmp = require'cmp'
local luasnip = require'luasnip'

-- luasnip setup
require('luasnip/loaders/from_vscode').lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'copilot', group_index = 2 },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can add git commits completions as well
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (search)
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (command)
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' }
  })
})
require("trouble").setup({
  modes = {
    preview_float = {
      mode = "diagnostics",
      preview = {
        type = "float",
        relative = "editor",
        border = "rounded",
        title = "Preview",
        title_pos = "center",
        position = { 0, -2 },
        size = { width = 0.3, height = 0.3 },
        zindex = 200,
      },
    },
  },
})

