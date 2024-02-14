vim.g.mapleader = " "

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.o.background = 'dark'
vim.cmd([[colorscheme catppuccin-mocha]])

vim.wo.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.cursorline = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.opt_global.shortmess:remove("F")

local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Navigate between buffers. Note: this is only useful with lualine showing horiztonal list of buffers
map('n', 'H', ':bp<CR>')
map('n', 'L', ':bn<CR>')

-- Delete current Buffer
map('n', '<leader>d', ':Bdelete<CR>')

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

vim.filetype.add({
	extension = {
		mdx = "markdown.mdx"
	}
})
