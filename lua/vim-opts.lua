vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set ignorecase")
vim.cmd("set smartcase")


vim.g.mapleader = " "
vim.keymap.set('n', '<C-l>', '<cmd>noh<cr>', {desc = 'Clear Highlight'})
vim.keymap.set('n', '<C-h>', '<cmd>set invrelativenumber<cr>', {desc = 'Toggle Relative Number'})
vim.keymap.set('n', '<C-y>', '"*Y', {desc = 'Clear Highlight'})
