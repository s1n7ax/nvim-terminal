# nvim-terminal

Terminal plugin to open/toggle the terminals in Neovim

![nvim-terminal demo](https://raw.githubusercontent.com/s1n7ax/nvim-terminal/main/resources/gif/demo.gif)

## Features

* Toggle terminal window
* Quick switching between multiple terminal buffers

## Install the plugin

**vim-plug**

```vim
Plug 's1n7ax/nvim-terminal'
```

## Add keymaps

```lua
terminal = require('nvim-terminal').DefaultTerminal;

local silent = { silent = true }

-- following option will hide the buffer when it is closed instead deleting
-- the buffer. This is important to reuse the last terminal buffer
-- IF the option is not set, plugin will open a new terminal every single time
vim.o.hidden = true

vim.api.nvim_set_keymap('n', '<leader>t', ':lua terminal:toggle()<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>1', ':lua terminal:open(1)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>2', ':lua terminal:open(2)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>3', ':lua terminal:open(3)<cr>', silent)
```

## Configuring the terminal window

```lua
local Terminal = require('nvim-terminal').Terminal
local Window = require('nvim-terminal').Window

local window = Window:new({
	pos = 'botright',
	split = 'sp',
	width = 50,
	height = 15
})

terminal = Terminal:new(window)
```

**pos** - Do `:h :leftabove` for more information
**split** - Do `:h split` for more information
**width** - Width of the terminal
**height** - Height of the terminal

NOTE: width or height may not be applied in some "pos"

## Change size on the fly

```lua
local Terminal = require('nvim-terminal').Terminal
local Window = require('nvim-terminal').Window

window = Window:new()
terminal = Terminal:new(window)

function window:change_height(by)
	local width, height = window:get_size()
	window.height = height + by
	window:update_size()
end

local silent = { silent = true }

vim.api.nvim_set_keymap('n', '<leader>+', ':lua window:change_height(3)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>-', ':lua window:change_height(-3)<cr>', silent)
```
