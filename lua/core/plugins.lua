local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- todo-comments
    { 
        "folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
        },
    },

	-- Neoformat
	{ "sbdchd/neoformat" },

    { "xiyaowong/transparent.nvim" },

	-- Hop
	{ "phaazon/hop.nvim" },

	-- Neo Tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
	},

    -- Symbos outline
    { 'simrat39/symbols-outline.nvim' },

    -- Mason
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            handlers = {}
        },
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "clang-format",
                "codelldb",
            }
        }
    },

	{ "nvim-treesitter/nvim-treesitter" },
	{ "neovim/nvim-lspconfig" },
	{ "joshdick/onedark.vim" },
	{ "cossonleo/dirdiff.nvim" },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{ "rebelot/kanagawa.nvim" },
	{ "scottmckendry/cyberdream.nvim" },
	{ "olivercederborg/poimandres.nvim" },
	{ "sainnhe/sonokai" },
	{ "tiagovla/tokyodark.nvim" },
    { "marko-cerovac/material.nvim" },
	{ "savq/melange-nvim" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "folke/neodev.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "jose-elias-alvarez/null-ls.nvim" },
	{ "numToStr/Comment.nvim" },
	{ "windwp/nvim-autopairs" },
	{ "windwp/nvim-ts-autotag" },
	{
	    'akinsho/bufferline.nvim',
	    -- tag = "*",
	    requires = 'nvim-tree/nvim-web-devicons',
    },
    {
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{ "lewis6991/gitsigns.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"linrongbin16/lsp-progress.nvim",
		},
	},
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{ "folke/which-key.nvim" },
	{ "olivercederborg/poimandres.nvim" },
	{ "xero/miasma.nvim" },
	{ "blazkowolf/gruber-darker.nvim" },
	{ "almo7aya/neogruvbox.nvim" },
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
	},
	{ "Pocco81/auto-save.nvim" },
})
