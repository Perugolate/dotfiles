-- gruffalo (cluster) nvim config. Kept as a near-copy of
-- .config/nvim/init.lua so `diff` shows only the cluster deltas:
--   - OSC52 clipboard (yank over ssh) instead of clipboard=unnamedplus
--   - no copilot / claudecode / typst
--   - LSPs guarded by executable() checks; R resolved from PATH
--   - mouse=r, guicursor, ipython repl kept from the old cluster config
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- Keep bulky, re-creatable data (plugins, treesitter parsers) on the fast
-- apps array instead of the quota'd home. Falls back to the usual paths
-- when the apps dir doesn't exist so this file still loads on the mac.
local apps = '/mnt/apps/users/pjohnsto'
local on_cluster = vim.fn.isdirectory(apps) == 1

-- Plug Ins start----------------------
local Plug = vim.fn['plug#']
vim.fn['plug#begin'](on_cluster and (apps .. '/nvim/plugged') or '~/.vim/plugged')
Plug 'lewis6991/gitsigns.nvim'
Plug 'kassio/neoterm'
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
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'kmarius/jsregexp'
Plug 'folke/trouble.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug('nextflow-io/vim-language-nextflow', { commit = '0be2ac1b325427617e4926c117fe1cdb6a8c3a4e' })
Plug 'folke/which-key.nvim'
Plug 'perugolate/undotree'
vim.fn['plug#end']()
-- Plug Ins end------------------------

vim.cmd.colorscheme('catppuccin-mocha')

-- No clipboard=unnamedplus here: there is no clipboard provider over ssh.
-- Yanks reach the local clipboard via the OSC52 TextYankPost autocmd below;
-- pasting FROM the local clipboard is the terminal's job (cmd-v).
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wildmenu = true                 -- visual autocomplete for command menu
vim.opt.showmatch = true                -- highlight matching [{()}]
vim.opt.hlsearch = true                 -- highlight matches
vim.opt.splitright = true               -- vsplit on the right
vim.opt.inccommand = 'nosplit'          -- turn on live substitution
vim.opt.undofile = true                 -- persistent undo across nvim restarts
vim.opt.ignorecase = true               -- case-insensitive search...
vim.opt.smartcase = true                -- ...unless the pattern has a capital
vim.opt.mouse = 'r'

-- inline diagnostics (off by default since nvim 0.11)
vim.diagnostic.config({ virtual_text = true })

-- OSC52 clipboard: emit escape sequences the local terminal turns into
-- clipboard writes. Only used explicitly (see TextYankPost); not wired to
-- unnamedplus because OSC52 *paste* is unsupported/blocked in most terminals.
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy,
    ['*'] = require('vim.ui.clipboard.osc52').copy,
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste,
    ['*'] = require('vim.ui.clipboard.osc52').paste,
  },
}
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
    local copy_to_unnamedplus = require('vim.ui.clipboard.osc52').copy('+')
    copy_to_unnamedplus(vim.v.event.regcontents)
    local copy_to_unnamed = require('vim.ui.clipboard.osc52').copy('*')
    copy_to_unnamed(vim.v.event.regcontents)
  end,
})

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
vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-blinkon0-TermCursor'

-- Use tab and shift-tab to cycle through windows.
vim.keymap.set('n', '<Tab>', '<C-W>w')
vim.keymap.set('n', '<S-Tab>', '<C-W>W')

vim.keymap.set('n', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.neoterm_default_mod = 'vertical'
vim.keymap.set('n', ',', ':TREPLSendLine<CR>')
vim.keymap.set('v', ',', ':TREPLSendSelection<CR>')
vim.g.neoterm_repl_python = 'ipython'
-- had to turn off bracketed paste as it breaks :TREPLSendLine in R
-- use paste magic instead of the exec command (can't remember why though)
-- presumably to handle the pasting of indented code
vim.g.neoterm_repl_ipython_magic = 1

-- Send RMarkdown code chunk (taken from https://github.com/daler/dotfiles).
-- When inside a code chunk, <Leader>cd selects the chunk and sends to neoterm:
-- /```{<CR>                       -> search for chunk delimiter
-- N                               -> find the *previous* match to ```{
-- j                               -> move down one line from the previous match
-- V                               -> enter visual line-select mode
-- /^```\n<CR>                     -> select until the closing delimiter
-- k                               -> back up one line so it isn't included
-- <Plug>(neoterm-repl-send)<CR>   -> send the selection to the neoterm terminal
-- /```{r<CR>                      -> go to the start of the next chunk
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

-- which-key: pop up a labeled menu of possible continuations after a
-- pending chord (e.g. <leader>); labels come from the desc= on keymaps
local wk = require('which-key')
wk.setup({})
wk.add({
  { '<leader>f', group = 'find / format' },
  { '<leader>h', group = 'harpoon' },
  { '<leader>x', group = 'diagnostics' },
})

-- harpoon: pin a per-project working set of files and jump to them with
-- one chord. <leader>ha adds the current file, <leader>hh shows/edits the
-- list, <leader>1-4 jump to slots.
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

-- snakefmt: format Snakefile/*.smk on save (auto_format), plus :Snakefmt /
-- :SnakefmtInfo. The binary is found via PATH
-- (/mnt/apps/users/pjohnsto/conda/bin/snakefmt). If nvim can't see it on
-- PATH, uncomment bin_path below.
require("snakefmt").setup({
  auto_format = true,
  -- bin_path = "/mnt/apps/users/pjohnsto/conda/bin/snakefmt",
})

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

-- ===== nvim-treesitter `main` branch =====
-- Parser compilation needs a C compiler and a tree-sitter CLI >= 0.26.1.
-- Drop a linux-x64 CLI binary in ~/opt/tree-sitter-cli-0.26.11/ (dir is
-- only prepended to PATH if it exists).
local ts_cli = vim.fn.expand('~/opt/tree-sitter-cli-0.26.11')
if vim.fn.isdirectory(ts_cli) == 1 then
  vim.env.PATH = ts_cli .. ':' .. vim.env.PATH
end

-- parsers go on the apps array too (default: stdpath('data')/site)
require('nvim-treesitter').setup(
  on_cluster and { install_dir = apps .. '/nvim/treesitter' } or {}
)

-- Install/refresh parsers (async; no-op once present). Lands in
-- ~/.local/share/nvim/site/parser. Run :TSUpdate to update them later.
require('nvim-treesitter').install({
  "c", "csv", "bash", "groovy", "latex", "lua", "luadoc", "markdown",
  "markdown_inline", "python", "r", "rnoweb", "snakemake", "ssh_config",
  "tsv", "vim", "vimdoc", "yaml", "json", "toml",
})

-- Highlighting is provided by Neovim, enabled per-buffer, skipping files
-- over 100 KB.
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > 100 * 1024 then
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

-- R Language Server: needs the languageserver package installed in this R
-- (styler ships with it, which is what <leader>fm formatting runs).
-- NB the guard must test the same binary the cmd uses, not 'R' on PATH.
local r_bin = '/mnt/apps/users/pjohnsto/conda/envs/r-lsp/bin/R'
if vim.fn.executable(r_bin) == 1 then
  vim.lsp.config.r_language_server = {
    cmd = { r_bin, '--slave', '-e', 'languageserver::run()' },
    filetypes = { 'r', 'R', 'rmd', 'Rmd' },
    root_markers = { '.git', 'DESCRIPTION', '.Rproj' },
  }
  vim.lsp.enable('r_language_server')
end

-- Nextflow LSP (only if the language server is installed on PATH)
if vim.fn.executable('nextflow-language-server') == 1 then
  vim.lsp.config.nextflow_ls = {
    cmd = { 'nextflow-language-server' },
    filetypes = { 'nextflow' },
    root_markers = { '.git', 'nextflow.config', 'main.nf' },
  }
  vim.lsp.enable('nextflow_ls')
end

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
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        -- esc closes telescope directly from insert mode (cluster habit)
        ["<esc>"] = require("telescope.actions").close,
        -- Yank the relative path in insert mode
        ["<C-y>"] = function(prompt_bufnr)
          local selection = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
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
      }
    }
  }
}
-- To get ui-select loaded and working with telescope
require("telescope").load_extension("ui-select")
require("catppuccin").setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
        comments = { "italic" },
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
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
