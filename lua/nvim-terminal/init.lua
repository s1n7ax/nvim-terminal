--use when developing
--[[ 
package.loaded['nvim-terminal.terminal'] = nil
package.loaded['nvim-terminal.window'] = nil
package.loaded['nvim-terminal'] = nil

vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>lua term:toggle()<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>1', '<cmd>lua term:open(1)<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>2', '<cmd>lua term:open(2)<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>3', '<cmd>lua term:open(3)<cr>', {})

vim.api.nvim_set_keymap('i', 'jk', '<esc>', {})
vim.api.nvim_set_keymap('n', '<c-s>', '<cmd>w<cr>', {})
vim.api.nvim_set_keymap('n', '<c-q>', '<cmd>q<cr>', {})
vim.api.nvim_set_keymap('n', ',r', '<cmd>luafile lua/nvim-terminal/init.lua<cr>', {})

local Terminal = require('nvim-terminal.terminal')
local Window = require('nvim-terminal.window')

local window = Window:new()
term = Terminal:new(window)
]]

return {
	Terminal = require('nvim-terminal.terminal'),
	Window = require('nvim-terminal.window'),
}
