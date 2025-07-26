-- ===================================================
-- centralized config file
vim.opt.number = true
vim.opt.numberwidth = 3

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
		-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/lsp.md#you-might-not-need-lsp-zero
		-- no lsp-zero setup
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "L3MON4D3/LuaSnip" },
		-- end

		-- colors
		{ "Yazeed1s/oh-lucy.nvim" },
		{ "sainnhe/edge" },
		{ "miikanissi/modus-themes.nvim", priority = 1000 },
		{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
		{ "marko-cerovac/material.nvim" },
		{ "techtuner/aura-neovim" },
		{ "savq/melange-nvim" },

		{ "nvim-telescope/telescope.nvim", dependencies = "nvim-lua/plenary.nvim" },
		{ "nvim-treesitter/nvim-treesitter", cmd = "TSUpdate" },
		{ "nvim-treesitter/playground" },
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
				--{ "3rd/image.nvim", opts = {} }, -- Optional image support in preview window: See `# Preview Mode` for more information
			},
			lazy = false, -- neo-tree will lazily load itself
			opts = { auto_expand_width = true },
		},
		{ "nvim-tree/nvim-web-devicons", opts = {} },
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},
		{ "tpope/vim-fugitive" },
		{ "lewis6991/gitsigns.nvim" },
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			init = function()
				vim.o.formatexpr = [[v:lua.require("conform").formatexpr()]]
			end,
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					--yaml = { "yamlfix" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			},
		},
		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {},
		},
		-- lazy.nvim
		-- TODO: increase timeout on messages
		{
			"folke/snacks.nvim",
			priority = 1000,
			lazy = false,
			---@type snacks.Config
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				bigfile = { enabled = true },
				dashboard = {
					preset = {
						header = [[
                                                              
@@@@@@@   @@@@@@   @@@@@@@@@@   @@@@@@@    @@@@@@   @@@       
@@@@@@@  @@@@@@@@  @@@@@@@@@@@  @@@@@@@@  @@@@@@@@  @@@       
  @@!    @@!  @@@  @@! @@! @@!  @@!  @@@  @@!  @@@  @@!       
  !@!    !@!  @!@  !@! !@! !@!  !@!  @!@  !@!  @!@  !@!       
  @!!    @!@!@!@!  @!! !!@ @!@  @!@@!@!   @!@!@!@!  @!!       
  !!!    !!!@!!!!  !@!   ! !@!  !!@!!!    !!!@!!!!  !!!       
  !!:    !!:  !!!  !!:     !!:  !!:       !!:  !!!  !!:       
  :!:    :!:  !:!  :!:     :!:  :!:       :!:  !:!   :!:      
   ::    ::   :::  :::     ::    ::       ::   :::   :: ::::  
   :      :   : :   :      :     :         :   : :  : :: : :  
                                                              
]],
					},
					sections = {
						{ section = "header" },
						{ section = "keys", gap = 1, padding = 1 },
						{ section = "startup" },
					},
					debug = false,
				},
				explorer = { enabled = true },
				indent = {
					indent = {
						enabled = false,
					},
					chunk = {
						enabled = true,
						char = {
							horizontal = "─",
							vertical = "│",
							corner_top = "╭",
							corner_bottom = "╰",
							arrow = "─",
						},
					},
				},
				input = { enabled = false },
				picker = { enabled = false },
				notifier = { enabled = false },
				quickfile = { enabled = true },
				scope = { enabled = true },
				scroll = { enabled = false },
				statuscolumn = { enabled = false },
				words = { enabled = true },
			},
		},
		{
			"folke/trouble.nvim",
			opts = {}, -- for default options, refer to the configuration section for custom setup.
			cmd = "Trouble",
			keys = {
				{
					"<leader>xx",
					"<cmd>Trouble diagnostics toggle<cr>",
					desc = "Diagnostics (Trouble)",
				},
				{
					"<leader>xX",
					"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
					desc = "Buffer Diagnostics (Trouble)",
				},
				{
					"<leader>cs",
					"<cmd>Trouble symbols toggle focus=false<cr>",
					desc = "Symbols (Trouble)",
				},
				{
					"<leader>cl",
					"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
					desc = "LSP Definitions / references / ... (Trouble)",
				},
				{
					"<leader>xL",
					"<cmd>Trouble loclist toggle<cr>",
					desc = "Location List (Trouble)",
				},
				{
					"<leader>xQ",
					"<cmd>Trouble qflist toggle<cr>",
					desc = "Quickfix List (Trouble)",
				},
			},
		},
		--{
		--	"folke/which-key.nvim",
		--	event = "VeryLazy",
		--	opts = {
		--		-- your configuration comes here
		--		-- or leave it empty to use the default settings
		--		-- refer to the configuration section below
		--	},
		--	keys = {
		--		{
		--			"<leader>?",
		--			function()
		--				require("which-key").show({ global = false })
		--			end,
		--			desc = "Buffer Local Keymaps (which-key)",
		--		},
		--	},
		--},
	},
	-- Configure any other settings here. See the documentation for more details.
	checker = { enabled = true, notify = false },
})

-- ===================================================
-- remaps
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>s", "<Cmd>Neotree toggle<CR>", { silent = true })

-- use option
-- instead of `option + [`, `option + ]` alternatively use `tj`, `tk`
vim.g.neovide_input_macos_alt_is_meta = true
vim.keymap.set({ "n" }, "<M-[>", function()
	vim.cmd(":bnext")
end, { desc = "Move tab left" })
vim.keymap.set({ "n" }, "<M-]>", function()
	vim.cmd(":bprev")
end, { desc = "Move tab right" })

vim.opt.syntax = "on"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.ai = true
vim.opt.number = true
vim.opt.hlsearch = true
vim.opt.ruler = true
vim.opt.nu = true
vim.opt.clipboard = "unnamed" -- universal yank
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

--vim.opt.termguicolors = false
vim.g.mapleader = " "
vim.g.python_recommended_style = 0

vim.o.background = "dark" -- or "light" for light mode

--vim.diagnostic.config({ virtual_lines = true })
vim.diagnostic.config({ virtual_text = true })

--vim.diagnostic.config({
--	float = {
--		source = "always",
--		border = border,
--	},
--})

-- ====================================
-- old lang settings
-- `autocmd FileType python setlocal shiftwidth=2 tabstop=2`
--vim.api.nvim_create_autocmd("FileType", {
--  pattern = "go",
--  command = "setlocal shiftwidth=2 tabstop=2 noexpandtab nolist"
--})
--

-- ===================================================
-- lsp
-- note: diagnostics are not exclusive to lsp servers
-- so these can be global keybindings
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }

		-- these will be buffer-local keybindings
		-- because they only work if you have an active language server

		-- TODO: replace with one liners
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "fr", function()
			require("telescope.builtin").lsp_references()
		end, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "<leader>v", ":vsplit | lua vim.lsp.buf.definition()<CR>")
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
	end,
})

--local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

--local default_setup = function(server)
--	print("default setup is called")
--	require("lspconfig")[server].setup({
--		capabilities = lsp_capabilities,
--	})
--end

-- ===================================================
-- mason
--require("mason").setup({})
--require("mason-lspconfig").setup({
--	ensure_installed = { "gopls" },
--	handlers = {
--		["gopls"] = function()
--			print("setting up gopls with custom flags")
--			local util = require("lspconfig").gopls.setup({
--				on_attach = on_attach,
--				capabilities = lsp_capabilities,
--				filetypes = { "go", "gomod" },
--				root_dir = util.root_pattern("go.mod", ".git"),
--				settings = {
--					gopls = {
--						buildFlags = { "-tags=integration" },
--					},
--				},
--			})
--		end,
--
--		-- default for everything else
--		default_setup,
--	},
--})

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup mason and mason-lspconfig
mason.setup()
mason_lspconfig.setup({
	ensure_installed = { "gopls" },
	automatic_installation = true,
})

-- Setup gopls manually
lspconfig.gopls.setup({
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/gopls" },
	capabilities = capabilities,
	root_dir = util.root_pattern("go.mod", ".git"),
	settings = {
		gopls = {
			buildFlags = { "-tags=unit integration" },
		},
	},
})

local cmp = require("cmp")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
	},
	mapping = cmp.mapping.preset.insert({
		-- Enter key confirms completion item
		["<CR>"] = cmp.mapping.confirm({ select = false }),

		-- Ctrl + space triggers completion menu
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})

-- ===================================================
-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>nn", function()
	builtin.commands()
end)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })

-- ===================================================
-- treesitter
require("nvim-treesitter.configs").setup({
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
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	command = "setlocal shiftwidth=4 tabstop=4 noexpandtab nolist",
})

-- TODO: set this dynamically
favorites = { "oh-lucy", "edge" }
---- HACK: this should appear before setting colorscheme
--vim.g.edge_style = "aura"
--vim.cmd.colorscheme("edge")
--vim.cmd.colorscheme("aura")
--vim.g.material_style = "darker"
--vim.cmd("colorscheme material")
vim.cmd("colorscheme melange")

--
--vim.cmd([[colorscheme moonfly]]) -- modus_operandi, modus_vivendi
-- lualine layout
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+
require("lualine").setup({
	options = {
		icons_enabled = true,
		component_separators = "|",
		section_separators = "",
	},
	--sections = {
	--	lualine_a = {
	--		"buffers",
	--	},
	--},
})

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)

		-- Actions
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
		map("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end)
		map("n", "<leader>hD", function()
			gitsigns.diffthis("~")
		end)
		map("n", "<leader>hQ", function()
			gitsigns.setqflist("all")
		end)
		map("n", "<leader>hs", gitsigns.stage_hunk)
		map("n", "<leader>hr", gitsigns.reset_hunk)
		map("n", "<leader>hS", gitsigns.stage_buffer)
		map("n", "<leader>hR", gitsigns.reset_buffer)
		map("n", "<leader>hp", gitsigns.preview_hunk)
		map("n", "<leader>hi", gitsigns.preview_hunk_inline)
		map("n", "<leader>hd", gitsigns.diffthis)
		map("n", "<leader>hq", gitsigns.setqflist)

		-- Custom actions
		map("n", "<leader>hD", function()
			gitsigns.diffthis("~")
		end)
		map("n", "<leader>td", gitsigns.toggle_deleted)

		-- Toggles
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
		map("n", "<leader>tw", gitsigns.toggle_word_diff)

		-- Text object
		map({ "o", "x" }, "ih", gitsigns.select_hunk)
	end,
})

vim.keymap.set("n", "<leader>to", ":TodoQuickFix<CR>")
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
