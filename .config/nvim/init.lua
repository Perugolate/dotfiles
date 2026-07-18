vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- Plug Ins start----------------------
local Plug = vim.fn['plug#']
vim.fn['plug#begin']('~/.vim/plugged')
Plug 'lewis6991/gitsigns.nvim'
Plug 'kassio/neoterm'
-- Plug 'junegunn/fzf'
-- Plug 'junegunn/fzf.vim'
Plug 'snakemake/snakefmt'
Plug('catppuccin/nvim', { as = 'catppuccin' })
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'stevearc/oil.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug('ThePrimeagen/harpoon', { branch = 'harpoon2' })
Plug('mg979/vim-visual-multi', { branch = 'master' })
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug('nvim-treesitter/nvim-treesitter', { branch = 'main', ['do'] = ':TSUpdate' })
Plug('nvim-treesitter/nvim-treesitter-textobjects', { branch = 'main' })
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'zbirenbaum/copilot.lua'
Plug 'perugolate/copilot-cmp'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'kmarius/jsregexp'
Plug 'folke/trouble.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug('nextflow-io/vim-language-nextflow', { commit = '0be2ac1b325427617e4926c117fe1cdb6a8c3a4e' })
Plug('chomosuke/typst-preview.nvim', { tag = 'v1.*' })
Plug 'coder/claudecode.nvim'
Plug 'folke/snacks.nvim'
Plug 'folke/which-key.nvim'
Plug 'perugolate/undotree'
vim.fn['plug#end']()
-- Plug Ins end------------------------

vim.cmd.colorscheme('catppuccin-mocha')

vim.opt.clipboard:append('unnamedplus') -- use clipboard rather then +/* registers
vim.opt.number = true                   -- turn on relative line numbering
vim.opt.relativenumber = true
vim.opt.wildmenu = true                 -- visual autocomplete for command menu
vim.opt.showmatch = true                -- highlight matching [{()}]
vim.opt.hlsearch = true                 -- highlight matches
vim.opt.splitright = true               -- vsplit on the right
vim.opt.inccommand = 'nosplit'          -- turn on live substitution
vim.opt.undofile = true                 -- persistent undo across nvim restarts
vim.opt.ignorecase = true               -- case-insensitive search...
vim.opt.smartcase = true                -- ...unless the pattern has a capital

-- inline diagnostics (off by default since nvim 0.11)
vim.diagnostic.config({ virtual_text = true })

-- move vertically by visual line
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- incremental search
vim.opt.incsearch = true
-- backspace clears search
vim.keymap.set('n', '<BS>', ':nohlsearch<CR>', { silent = true })

-- quick terminal/window navigation, and terminal mode exit
-- fix terminal mode Alt+b and Alt+f line navigation and Alt+. for last
-- argument
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<A-h>', [[<C-\><C-n><C-w>h]])
vim.keymap.set('t', '<A-j>', [[<C-\><C-n><C-w>j]])
vim.keymap.set('t', '<A-k>', [[<C-\><C-n><C-w>k]])
vim.keymap.set('t', '<A-l>', [[<C-\><C-n><C-w>l]])
vim.keymap.set('t', '<A-b>', '<Esc>b')
vim.keymap.set('t', '<A-f>', '<Esc>f')
vim.keymap.set('t', '<A-.>', '<Esc>.')
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-l>', '<C-w>l')

-- get rid of line numbers after opening terminal in a split
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.opt_local.number = false
  end,
})

-- match terminal cursor style form mac (zsh vi insert mode solid vertical bar)
-- also gives terminal mode a non-blinking bar as its fallback cursor, so R
-- (which resets the cursor to the terminal default) keeps the vertical line
-- vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-blinkon0-TermCursor'

-- Use tab and shift-tab to cycle through windows.
vim.keymap.set('n', '<Tab>', '<C-W>w')
vim.keymap.set('n', '<S-Tab>', '<C-W>W')

vim.keymap.set('n', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.neoterm_default_mod = 'vertical'
vim.keymap.set('n', ',', ':TREPLSendLine<CR>')
vim.keymap.set('v', ',', ':TREPLSendSelection<CR>')
-- set the neoterm python repl
-- --no-autoindent was necessary before implementation of bracketed paste
-- vim.g.neoterm_repl_python = 'ipython --no-autoindent'
-- vim.g.neoterm_repl_python = 'ipython'
-- vim.g.neoterm_bracketed_paste = 1
-- had to turn off bracketed paste as it breaks :TREPLSendLine in R
-- use paste magic instead of the exec command (can't remember why though)
-- presumably to handle the pasting of indented code
vim.g.neoterm_repl_ipython_magic = 1
-- send an rmarkdown chunk to the repl (recursive: uses <Plug>(neoterm-repl-send))
vim.keymap.set('n', '<Leader>cd',
  [[/```{<CR>NjV/```\n<CR>k<Plug>(neoterm-repl-send)<CR>/```{r<CR>]],
  { remap = true })

-- undotree: browse/restore the full undo history (incl. branches and
-- past sessions via undofile). NB <leader> maps must come after mapleader.
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<cr>', { desc = 'Undo tree' })

vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<cr>')
-- Telescope mappings
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

-- disable arrows for time being
-- note this also disables scrolling
vim.keymap.set('', '<Up>', '<nop>')
vim.keymap.set('', '<Down>', '<nop>')
vim.keymap.set('', '<Left>', '<nop>')
vim.keymap.set('', '<Right>', '<nop>')

vim.opt.foldenable = false

vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, { silent = true })

require('lualine').setup {
    options = {
        theme = "catppuccin-mocha"
    }
}
require('gitsigns').setup()

-- copilot.lua provides the agent; copilot-cmp exposes it as the 'copilot'
-- cmp source. Ghost text and panel are disabled per copilot-cmp's docs
-- (they clash with the cmp menu).
require('copilot').setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
require('copilot_cmp').setup()

-- which-key: pop up a labeled menu of possible continuations after a
-- pending chord (e.g. <leader>); labels come from the desc= on keymaps
local wk = require('which-key')
wk.setup({})
wk.add({
  { '<leader>f', group = 'find / format' },
  { '<leader>h', group = 'harpoon' },
  { '<leader>x', group = 'diagnostics' },
  { '<leader>a', group = 'claude' },
})

-- harpoon (trial, added 2026-07-18): pin a per-project working set of
-- files and jump to them with one chord. <leader>ha adds the current
-- file, <leader>hh shows/edits the list, <leader>1-4 jump to slots.
local harpoon = require('harpoon')
harpoon:setup()
vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end,
  { desc = 'Harpoon: add file' })
vim.keymap.set('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
  { desc = 'Harpoon: menu' })
for i = 1, 4 do
  vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end,
    { desc = 'Harpoon: file ' .. i })
end

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
    -- no LSP for snakemake: buffer-local <leader>fm shadows the global
    -- LSP-format map and runs snakefmt instead (also auto-runs on save)
    vim.keymap.set('n', '<leader>fm', function()
      require('snakefmt').format()
    end, { buffer = args.buf, desc = 'Format buffer (snakefmt)' })
  end,
})
-- R: 2-space indentation, matching the tidyverse default that both lintr
-- (diagnostics) and styler (formatting) assume. languageserver's formatter
-- runs styler with indent = the buffer's shiftwidth, so this also makes
-- formatting produce lintr-clean output.
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'r', 'rmd' },
  callback = function(args)
    vim.bo[args.buf].expandtab = true
    vim.bo[args.buf].shiftwidth = 2
    vim.bo[args.buf].softtabstop = 2
    vim.bo[args.buf].tabstop = 2
  end,
})

-- Format buffer (normal) or selection (visual) via the attached LSP.
-- For R this is styler inside languageserver. gq{motion} also formats
-- through the LSP formatexpr that attaches automatically.
vim.keymap.set({ 'n', 'x' }, '<leader>fm', function()
  vim.lsp.buf.format({ async = true })
end, { desc = 'Format buffer/selection (LSP)' })

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

-- treesitter textobjects (main branch, matching nvim-treesitter main):
-- syntax-aware nouns for the vim grammar. af/if = function, aa/ia =
-- argument, ac/ic = class; ]f/[f move to next/previous function.
require('nvim-treesitter-textobjects').setup({
  select = { lookahead = true }, -- act on the next textobject if not inside one
  move = { set_jumps = true },   -- ]f/[f push to the jumplist (<C-o> to return)
})
local ts_select = function(query)
  return function()
    require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
  end
end
local ts_move = function(fn, query)
  return function()
    require('nvim-treesitter-textobjects.move')[fn](query, 'textobjects')
  end
end
vim.keymap.set({ 'x', 'o' }, 'af', ts_select('@function.outer'), { desc = 'a function' })
vim.keymap.set({ 'x', 'o' }, 'if', ts_select('@function.inner'), { desc = 'inner function' })
vim.keymap.set({ 'x', 'o' }, 'aa', ts_select('@parameter.outer'), { desc = 'an argument' })
vim.keymap.set({ 'x', 'o' }, 'ia', ts_select('@parameter.inner'), { desc = 'inner argument' })
vim.keymap.set({ 'x', 'o' }, 'ac', ts_select('@class.outer'), { desc = 'a class' })
vim.keymap.set({ 'x', 'o' }, 'ic', ts_select('@class.inner'), { desc = 'inner class' })
vim.keymap.set({ 'n', 'x', 'o' }, ']f', ts_move('goto_next_start', '@function.outer'), { desc = 'Next function' })
vim.keymap.set({ 'n', 'x', 'o' }, '[f', ts_move('goto_previous_start', '@function.outer'), { desc = 'Previous function' })

local cmp = require'cmp'
local luasnip = require'luasnip'

-- R Language Server. root_markers resolves the project root per buffer;
-- attaching is filetype-driven via vim.lsp.enable.
vim.lsp.config.r_language_server = {
  cmd = { "/Users/paul/miniforge3/envs/glmgampoi/bin/R", "--slave", "-e", "languageserver::run()" },
  filetypes = { "r", "R", "rmd", "Rmd" },
  root_markers = { '.git', 'DESCRIPTION', '.Rproj' },
}
vim.lsp.enable('r_language_server')

-- Nextflow LSP
vim.lsp.config.nextflow_ls = {
  cmd = { 'nextflow-language-server' },
  filetypes = { 'nextflow' },
  root_markers = { '.git', 'nextflow.config', 'main.nf' },
}
vim.lsp.enable('nextflow_ls')

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
    -- no group_index on copilot: with one it only surfaced when every other
    -- source (incl. buffer) returned nothing, i.e. essentially never
    { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
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
-- diagnostics list: <leader>xx uses the float-preview mode defined above,
-- <leader>xX restricts to the current buffer
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble preview_float toggle<cr>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer diagnostics (Trouble)' })
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
