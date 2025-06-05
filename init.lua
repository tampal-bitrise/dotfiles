-- ===================================================
-- centralized config file
vim.opt.number = true

-- ===================================================
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here

    -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#you-might-not-need-lsp-zero
    -- no lsp-zero setup
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},
    -- end

    {'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim'},
    {'nvim-treesitter/nvim-treesitter', cmd = "TSUpdate"},
    {'nvim-treesitter/playground'},
    {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  lazy = false, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    -- fill any relevant options here
  },
}

  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- ===================================================
-- remaps
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', "<leader>s", '<Cmd>Neotree toggle<CR>', {silent = true})

-- TO ADD
-- treesitter
-- ranger ?

vim.opt.syntax = "on"
vim.opt.tabstop= 2
vim.opt.shiftwidth= 2
vim.opt.expandtab = true
vim.opt.ai = true
vim.opt.number = true
vim.opt.hlsearch = true
vim.opt.ruler = true
vim.opt.nu = true
vim.opt.clipboard = "unnamed" -- universal yank
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

--vim.opt.termguicolors = false
vim.g.mapleader = " "
vim.g.python_recommended_style = 0

vim.o.background = "dark" -- or "light" for light mode

vim.diagnostic.config({
  float = {
    source = 'always',
    border = border
  },
})

-- ====================================
-- old lang settings
-- `autocmd FileType python setlocal shiftwidth=2 tabstop=2`
--vim.api.nvim_create_autocmd("FileType", {
--  pattern = "go",
--  command = "setlocal shiftwidth=2 tabstop=2 noexpandtab nolist"
--})
--
---- autoclose setup
--require("autoclose").setup()

--own custom keymaps
--vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--vim.keymap.set('n', '<leader>v', ':vsplit | lua vim.lsp.buf.definition()<CR>')

-- ===================================================
-- lsp
-- note: diagnostics are not exclusive to lsp servers
-- so these can be global keybindings
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>') 


vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('n', '<leader>v', ':vsplit | lua vim.lsp.buf.definition()<CR>')
  end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
  require('lspconfig')[server].setup({
    capabilities = lsp_capabilities,
  })
end

-- ===================================================
-- mason
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'gopls'},
  handlers = {
    default_setup,
  },
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    -- Enter key confirms completion item
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl + space triggers completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

-- ===================================================
-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>nn', function()
  builtin.commands();
end)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- ===================================================
-- treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  --ensure_installed = { "javascript", "typescript", "rust", "python", "c", "lua", "vim", "vimdoc", "query" },
  ensure_installed = { "lua", "vim", "vimdoc", "go" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,

    --disable = {"rust", "markdown"},
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  command = "setlocal shiftwidth=2 tabstop=2 noexpandtab nolist"
})

vim.cmd 'colorscheme vim' -- if the above fails, then use default
