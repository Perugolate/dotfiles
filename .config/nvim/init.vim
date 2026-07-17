let $NVIM_TUI_ENABLE_TRUE_COLOR=1
""Plug Ins start----------------------
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'kassio/neoterm'
"Plug 'junegunn/fzf'
"Plug 'junegunn/fzf.vim'
Plug 'snakemake/snakefmt'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'stevearc/oil.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'main', 'do': ':TSUpdate' }
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-copilot'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'kmarius/jsregexp'
Plug 'folke/trouble.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'dense-analysis/ale'
Plug 'nextflow-io/vim-language-nextflow', { 'commit': '0be2ac1b325427617e4926c117fe1cdb6a8c3a4e' }
Plug 'chomosuke/typst-preview.nvim', { 'tag': 'v1.*' }
Plug 'coder/claudecode.nvim'
Plug 'folke/snacks.nvim'
call plug#end()
"Plug Ins end------------------------

colorscheme catppuccin-mocha

set clipboard+=unnamedplus   " use clipboard rather then +/* registers
set nu rnu                   " turn on relative line numbering
set wildmenu                 " visual autocomplete for command menu
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

" match terminal cursor style form mac (zsh vi insert mode solid vertical bar)
" also gives terminal mode a non-blinking bar as its fallback cursor, so R
" (which resets the cursor to the terminal default) keeps the vertical line
"set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-blinkon0-TermCursor

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
nmap <Leader>cd /```{<CR>NjV/```\n<CR>k<Plug>(neoterm-repl-send)<CR>/```{r<CR>

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
"nnoremap <C-p> :Files<Cr>
" Jump to open buffer
"let g:fzf_buffers_jump = 1
nnoremap <C-p> <cmd>Telescope find_files<cr>
" Telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
"
" disable arrows for time being
" note this also disables scrolling
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

set nofoldenable

nnoremap <silent> ca <cmd>lua vim.lsp.buf.code_action()<CR>

lua << END
require('lualine').setup {
    options = {
        theme = "catppuccin-mocha"
    }
}
require("oil").setup()
-- '-' opens the current file's parent directory as an editable oil buffer
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory (oil)" })

-- snakefmt: format Snakefile/*.smk. Binary resolved from PATH (~/miniforge3/bin).
-- auto_format=true => format on save; also provides :Snakefmt and :SnakefmtInfo.
-- Set auto_format=false if you'd rather format manually with :Snakefmt.
require("snakefmt").setup({ auto_format = true })

-- Snakefiles must be space-indented. The snakemake filetype has no ftplugin,
-- so it inherits expandtab=off + tabstop=8 => <CR>/autoindent inserts TABs,
-- which breaks `snakemake` and makes the file unparseable for snakefmt.
-- Force 4-space indentation instead.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'snakemake',
  callback = function(args)
    vim.bo[args.buf].expandtab = true
    vim.bo[args.buf].shiftwidth = 4
    vim.bo[args.buf].softtabstop = 4
    vim.bo[args.buf].tabstop = 4
  end,
})
-- ===== nvim-treesitter `main` branch (migrated from `master` 2026-07-16) =====
-- On `main` there is no ensure_installed/highlight/auto_install: install()
-- replaces ensure_installed, and highlighting is started manually per buffer.

-- Pin a tree-sitter CLI >= 0.26.1 (required by `main` to compile parsers).
-- Your global ~/opt/tree-sitter is 0.25.2 (too old) and is left untouched;
-- this only prepends to PATH for processes nvim spawns.
vim.env.PATH = vim.fn.expand('~/opt/tree-sitter-cli-0.26.11') .. ':' .. vim.env.PATH

require('nvim-treesitter').setup() -- default install_dir = stdpath('data')/site

-- Install/refresh parsers (async; no-op once present). Lands in
-- ~/.local/share/nvim/site/parser. Run :TSUpdate to update them later.
require('nvim-treesitter').install({
  "c", "csv", "bash", "groovy", "latex", "lua", "luadoc", "markdown",
  "markdown_inline", "python", "r", "rnoweb", "snakemake", "ssh_config",
  "tsv", "vim", "vimdoc", "yaml", "json", "toml",
})

-- Highlighting is provided by Neovim, enabled per-buffer. This replaces
-- master's `highlight = { enable = true, disable = <largefile fn> }`.
-- (master's `disable = { "c", "rust" }` was shadowed by the function below
-- and never actually took effect, so only the large-file guard is kept.)
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > 100 * 1024 then -- skip TS on files > 100 KB
      return
    end
    pcall(vim.treesitter.start, args.buf) -- no-op if no parser for this filetype
  end,
})

local cmp = require'cmp'
local luasnip = require'luasnip'

-- R Language Server (modern vim.lsp.config approach)
vim.lsp.config.r_language_server = {
  cmd = { "/Users/paul/miniforge3/envs/glmgampoi/bin/R", "--slave", "-e", "languageserver::run()" },
  filetypes = { "r", "R", "rmd", "Rmd" },
  root_dir = vim.fs.root(0, { '.git', 'DESCRIPTION', '.Rproj' }),
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'r', 'rmd' },
  callback = function(args)
    vim.lsp.enable('r_language_server', { bufnr = args.buf })
  end,
})

-- Nextflow LSP setup (modern vim.lsp.config approach)
vim.lsp.config.nextflow_ls = {
  cmd = { 'nextflow-language-server' },
  filetypes = { 'nextflow' },
  root_dir = vim.fs.root(0, { '.git', 'nextflow.config', 'main.nf' }),
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'nextflow',
  callback = function(args)
    vim.lsp.enable('nextflow_ls', { bufnr = args.buf })
  end,
})

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
-- This is your opts table
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        -- Yank the relative path in insert mode
        ["<C-y>"] = function(prompt_bufnr)
          local selection = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
          -- Try to get the display value first (relative path), fallback to full path if needed
          local path = selection.ordinal or selection.display or selection.filename or selection.path
          vim.fn.setreg("+", path)
          vim.fn.setreg("\"", path)
          vim.notify("Yanked: " .. path, vim.log.levels.INFO)
        end,
      },
      n = {
        -- Yank the relative path in normal mode
        ["y"] = function(prompt_bufnr)
          local selection = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
          -- Try to get the display value first (relative path), fallback to full path if needed
          local path = selection.ordinal or selection.display or selection.filename or selection.path
          vim.fn.setreg("+", path)
          vim.fn.setreg("\"", path)
          vim.notify("Yanked: " .. path, vim.log.levels.INFO)
        end,
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- your existing settings
      }
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
require("catppuccin").setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

vim.lsp.config.tinymist = {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  settings = {
    formatterMode = 'typstyle',
    exportPdf = 'onType',
  },
}

vim.lsp.enable('tinymist')

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"

require("claudecode").setup()

vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>",       { desc = "Toggle Claude" })
vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>",  { desc = "Focus Claude window" })
vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",  { desc = "Add current buffer" })
vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>",   { desc = "Send selection" })
vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   { desc = "Deny diff" })

