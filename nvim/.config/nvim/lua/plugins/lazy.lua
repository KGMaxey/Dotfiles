return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { 'windwp/nvim-ts-autotag' }
    },
    config = function()
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
        -- autotag = {
        -- 	enable = true
        -- },
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
      provider_selector = function(bufnr, filetype, buftype)
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
        'hrsh7th/cmp-nvim-lsp',
        config = function()
          local cmp = require('cmp')


-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

          local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

          cmp.setup({
            sources = {
              {name = 'nvim_lsp'},
            },
            snippet = {
              expand = function(args)
                -- You need Neovim v0.10 to use vim.snippet
                vim.snippet.expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ['<CR>'] = cmp.mapping.confirm({ select = false }),
                  ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
              -- ['<Tab>'] = cmp.mapping.scroll_docs(-4),
              -- ['<S-Tab>'] = cmp.mapping.scroll_docs(4),
            }),
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered()
            }
          })
  --     cmp.setup({
  --       mapping = {
  --         ['<CR>'] = cmp.mapping.confirm({ select = false })
  --       },
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered()
  --       }
  --     })
        end
      }, -- Required
      { 'hrsh7th/nvim-cmp' }, -- Required
      {
        'williamboman/mason.nvim',
        config = function()
          require('mason').setup({})
        end
      }, -- Optional
      { 
        'williamboman/mason-lspconfig.nvim',
        config = function()
          require('mason-lspconfig').setup({
            handlers = {
              function(server_name)
                require('lspconfig')[server_name].setup({})
              end
            }
          })
        end
      }, -- Optional
      { 'L3MON4D3/LuaSnip' }, -- Required
      { 'neovim/nvim-lspconfig' }, -- Required

      -- Autocompletion
  -- {
  --   'VonHeikemen/lsp-zero.nvim',
  --   branch = 'v2.x',
  --   dependencies = {
  --     -- LSP Support
  --     { 'neovim/nvim-lspconfig' }, -- Required
  --     { 'williamboman/mason.nvim' }, -- Optional
  --     { 'williamboman/mason-lspconfig.nvim' }, -- Optional

  --     -- Autocompletion
  --     { 'hrsh7th/nvim-cmp' }, -- Required
  --     { 'hrsh7th/cmp-nvim-lsp' }, -- Required
  --     { 'L3MON4D3/LuaSnip' }, -- Required
  --   },
  --   config = function()
  --     local lsp = require('lsp-zero')
  --     local cmp = require('cmp')

  --     lsp.preset({
  --       manage_nvim_cmp = {
  --         set_extra_mappings = true
  --       }
  --     })

  --     lsp.on_attach(function(_, bufnr)
  --       lsp.default_keymaps({ buffer = bufnr })
  --     end)

  --     lsp.setup()

  --     cmp.setup({
  --       mapping = {
  --         ['<CR>'] = cmp.mapping.confirm({ select = false })
  --       },
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered()
  --       }
  --     })
  --   end
  -- },
  {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      vim.keymap.set('n', '<leader>ff', function() builtin.find_files { hidden = true } end, {})
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
      theme = 'kanagawa',
      sections = {
        lualine_b = { 'buffers' },
        lualine_c = { 'branch', 'diff', 'diagnostics' },
        lualine_x = { 'encoding', 'fileformat', 'filetype', { 'filename', path = 1 } },
      },
      options = { section_separators = '', component_separators = '' },
      extensions = {'nvim-tree'}
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
    config = function()
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
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
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
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  }
}
