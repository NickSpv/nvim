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
	-- Neoformat
	{ "sbdchd/neoformat" },

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

	-- Dap, Mason
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = "mfussenegger/nvim-dap",
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup()
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
          dap.configurations.c = {
            {
                -- Change it to "cppdbg" if you have vscode-cpptools
                type = "codelldb",
                request = "launch",
                program = function ()
                    -- Compile and return exec name
                    local filetype = vim.bo.filetype
                    local filename = vim.fn.expand("%")
                    local basename = vim.fn.expand('%:t:r')
                    local makefile = os.execute("(ls | grep -i makefile)")
                    if makefile == "makefile" or makefile == "Makefile" then
                        os.execute("make debug")
                    else
                        if filetype == "c" then
                            os.execute(string.format("gcc -g -o %s %s", basename, filename))
                        else
                            os.execute(string.format("g++ -g -o %s %s", basename, filename))
                        end
                    end
                    return basename
                end,
                args = function ()
                    local argv = {}
                    arg = vim.fn.input(string.format("argv: "))
                    for a in string.gmatch(arg, "%S+") do
                        table.insert(argv, a)
                    end
                    vim.cmd('echo ""')
                    return argv
                end,
                cwd = "${workspaceFolder}",
                -- Uncomment if you want to stop at main
                -- stopAtEntry = true,
                MIMode = "gdb",
                miDebuggerPath = "/usr/bin/gdb",
                setupCommands = {
                    {
                        text = "-enable-pretty-printing",
                        description = "enable pretty printing",
                        ignoreFailures = false,
                    },
                },
            },
        }
        end
      },
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
        "mfussenegger/nvim-dap",
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
	{ "akinsho/bufferline.nvim" },
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
