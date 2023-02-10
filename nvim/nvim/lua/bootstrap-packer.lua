local M = {}

function M.bootstrap()
  local ensure_packer = function()
    local fn = vim.fn
  	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  	if fn.empty(fn.glob(install_path)) > 0 then
  	  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  	  vim.cmd [[packadd packer.nvim]]
  	  return true
  	end
  	return false
	end

	local packer_bootstrap = ensure_packer()

	return require('packer').startup({
		function(use)
	  	use 'wbthomason/packer.nvim'

			use {
				"ellisonleao/gruvbox.nvim",
				config = function () require("gruvbox").setup() end
			}

			use {
    	  'numToStr/Comment.nvim',
        keys = { "gc", "gb" },
    	  config = function ()
    	      require('Comment').setup()
    	  end
			}

      use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function () require("lualine").setup {
          options = {
            theme = "gruvbox_dark"
          }
        } end,
      }

      use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.x',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function ()
          local actions = require("telescope.actions")
          require("telescope").setup {
            defaults = {
              mappings = {
                i = {
                  ["<C-j>"] = actions.move_selection_next,
                  ["<C-k>"] = actions.move_selection_previous
                }
              }
            },
          }
        end
      }

      use {
        'nvim-treesitter/nvim-treesitter',
        run = function () require("nvim-treesitter.install").update { with_sync = true }() end,
        config = function () require("nvim-treesitter.configs").setup {
          highlight = {
            enable = true,
          },
          context_commentstring = {
            enable = true,
          },
          rainbow = {
            enable = true,
            max_file_lines = nil,
          },
          autotag = { enable = true },
          incremental_selection = { enable = true },
        } end
      }

      use {
        'p00f/nvim-ts-rainbow',
        after = 'nvim-treesitter'
      }

      use {
        'windwp/nvim-ts-autotag',
        after = 'nvim-treesitter'
      }

      use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function () require('nvim-autopairs').setup {} end
      }

      -- Automatically set up your configuration after cloning packer.nvim
      -- Put this at the end after all plugins
      if packer_bootstrap then
        require('packer').sync()
      end
		end,
		config = {
      display = {
        open_fn = function()
          return require('packer.util').float({ border = 'rounded' }) end,
        },
      }
    })
end

return M
