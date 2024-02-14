return {
  { "folke/which-key.nvim" },
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{ 'windwp/nvim-ts-autotag' }
		},
    config = function ()
      require('nvim-treesitter.configs').setup {
			  ensure_installed = {
			  	-- defaults
			  	"vim",
			  	"lua",
			  	"markdown",
			  	"html",
			  	"css",
			  	"javascript",
			  	"typescript",
			  	"json",
			  	"c_sharp",
			  	"sql",
			  	"yaml",
			  	"xml",
			  	"tsx",
			  },
			  autotag = {
			  	enable = true
			  },
        highlight = {
          enable = true
        }
      }
    end
	},
	{
		'kevinhwang91/nvim-ufo',
		dependencies = {
			'kevinhwang91/promise-async'
		},
		keys = {
			{
				"zR",
				function() require("ufo").openAllFolds() end,
			},
			{
				"zM",
				function() require("ufo").closeAllFolds() end,
			},
			{
				"zr",
				function() require("ufo").openFoldsExceptKinds { "comment" } end,
			},
			{
				"zm",
				function() require("ufo").closeFoldsWith() end,
			},
		},
		opts = {
			provider_selector = function (bufnr, filetype, buftype)
				return { 'treesitter', 'indent' }
			end
		}
	},
	{
		"windwp/nvim-ts-autotag",
		lazy = false,
		config = function()
			require('nvim-ts-autotag').setup()
		end,
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{ 'williamboman/mason.nvim' }, -- Optional
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'L3MON4D3/LuaSnip' }, -- Required
		},
		config = function()
			local lsp = require('lsp-zero')
			local cmp = require('cmp')

			lsp.preset({
				manage_nvim_cmp = {
					set_extra_mappings = true
				}
			})

			lsp.on_attach(function(_, bufnr)
				lsp.default_keymaps({ buffer = bufnr })
			end)

			lsp.setup()

			cmp.setup({
				mapping = {
					['<CR>'] = cmp.mapping.confirm({ select = false })
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered()
				}
			})
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require('telescope.builtin')
			local telescope = require('telescope')
			local actions = require('telescope.actions')

			vim.keymap.set('n', '<leader>ff', function () builtin.find_files{hidden=true} end, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
			vim.keymap.set('n', '<leader>fr', builtin.resume, {})

			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,
						},
					},
				},
			})
		end
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			theme = 'gruvbox',
			sections = {
        lualine_b = { 'buffers' },
        lualine_c = { 'branch', 'diff', 'diagnostics' },
        lualine_x = { 'encoding', 'fileformat', 'filetype', {'filename', path = 1 } },
			},
			options = { section_separators = '', component_separators = '' }
		}
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {}
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function ()
			require('telescope').load_extension "file_browser"
		end,
		keys = {
			{
				"<leader>fe",
				"<cmd>Telescope file_browser<CR>",
			},
		}
	},
  { 'tpope/vim-fugitive' },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons'
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function ()
      require('nvim-tree').setup {
        update_focused_file = { enable = true },
        sort = { sorter = 'case_sensitive' },
        view = { width = 45 },
        renderer = { group_empty = true },
        filters = { dotfiles = true }
      }
    end,
    keys = {
      {
        "<leader>tt",
        "<cmd>NvimTreeToggle<CR>"
      }
    }
  },
  {
    'famiu/bufdelete.nvim'
  }
}
}
