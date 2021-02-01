-- use when developing
package.loaded['nvim-terminal.terminal'] = nil
package.loaded['nvim-terminal.window'] = nil
package.loaded['nvim-terminal'] = nil

vim.api.nvim_set_keymap('i', 'jk', '<esc>', {})
vim.api.nvim_set_keymap('n', '<c-s>', '<cmd>w<cr>', {})
vim.api.nvim_set_keymap('n', '<c-q>', '<cmd>q<cr>', {})
vim.api.nvim_set_keymap('n', ',r', '<cmd>luafile lua/nvim-terminal/init.lua<cr>', {})

local Terminal = require('nvim-terminal.terminal')
local Window = require('nvim-terminal.window')

local window = Window:new()
terminal = Terminal:new(window)

vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>lua terminal:toggle()<cr>', {})
