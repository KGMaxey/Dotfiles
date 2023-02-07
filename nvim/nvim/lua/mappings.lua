local map = vim.keymap.set

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local find_files = function() require("telescope.builtin").find_files() end
map("n", "<leader>ff", find_files, { desc = "Search files" })
