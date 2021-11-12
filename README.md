# nvim-terminal

Terminal plugin to open/toggle the terminals in Neovim

https://user-images.githubusercontent.com/18459807/129582749-2e732591-cb8d-4cb8-a427-9da0c79a621d.mp4

## Features

* Toggle terminal window
* Quick switching between multiple terminal buffers

## Install the plugin

**packer**
```lua
use {
    's1n7ax/nvim-terminal',
    config = function()
        vim.o.hidden = true
        require('nvim-terminal').setup()
    end,
}
```

## Default Keymaps

<kbd>leader</kbd> + <kbd>;</kbd> - **Toggle open/close terminal**

<kbd>leader</kbd> + <kbd>1</kbd> - **Open terminal 1**

<kbd>leader</kbd> + <kbd>2</kbd> - **Open terminal 2**

<kbd>leader</kbd> + <kbd>3</kbd> - **Open terminal 3**

<kbd>leader</kbd> + <kbd>4</kbd> - **Open terminal 4**

<kbd>leader</kbd> + <kbd>5</kbd> - **Open terminal 5**

<kbd>leader</kbd> + <kbd>+</kbd> - **Increase window height**

<kbd>leader</kbd> + <kbd>-</kbd> - **Decrease window height**

<kbd>leader</kbd> + <kbd>leader</kbd> + <kbd>+</kbd> - **Increase window width**

<kbd>leader</kbd> + <kbd>leader</kbd> + <kbd>-</kbd> - **Decrease window width**

## Configuration

Simply pass the custom configuration to `setup` method

```lua
-- following option will hide the buffer when it is closed instead of deleting
-- the buffer. This is important to reuse the last terminal buffer
-- IF the option is not set, plugin will open a new terminal every single time
vim.o.hidden = true

require('nvim-terminal').setup({
    window = {
        -- Do `:h :botright` for more information
        -- NOTE: width or height may not be applied in some "pos"
        position = 'botright',

        -- Do `:h split` for more information
        split = 'sp',

        -- Width of the terminal
        width = 50,

        -- Height of the terminal
        height = 15,
    },

    -- keymap to disable all the default keymaps
    disable_default_keymaps = false,

    -- keymap to toggle open and close terminal window
    toggle_keymap = '<leader>;',

    -- increase the window height by when you hit the keymap
    window_height_change_amount = 2,

    -- increase the window width by when you hit the keymap
    window_width_change_amount = 2,

    -- keymap to increase the window width
    increase_width_keymap = '<leader><leader>+',

    -- keymap to decrease the window width
    decrease_width_keymap = '<leader><leader>-',

    -- keymap to increase the window height
    increase_height_keymap = '<leader>+',

    -- keymap to decrease the window height
    decrease_height_keymap = '<leader>-',

    terminals = {
        -- keymaps to open nth terminal
        {keymap = '<leader>1'},
        {keymap = '<leader>2'},
        {keymap = '<leader>3'},
        {keymap = '<leader>4'},
        {keymap = '<leader>5'},
    },
})
```

## Add Keymaps Manually

`nvim-terminal` adds a global variable called `NTGlobal`. When you call
`require('nvim-terminal').setup()` it adds `terminal` and `window` properties to
`NTGlobal`

```lua
vim.api.nvim_set_keymap('n', '<leader>t', ':lua NTGlobal["terminal"]:toggle()<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>1', ':lua NTGlobal["terminal"]:open(1)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>+', ':lua NTGlobal["window"]:change_height(2)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>-', ':lua NTGlobal["window"]:change_height(-2)<cr>', silent)
```

## PRO MODE

### Default Terminal

```lua
terminal = require('nvim-terminal').DefaultTerminal;

local silent = { silent = true }

vim.api.nvim_set_keymap('n', '<leader>t', ':lua terminal:toggle()<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>1', ':lua terminal:open(1)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>2', ':lua terminal:open(2)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>3', ':lua terminal:open(3)<cr>', silent)
```

### Customized Window

```lua
local Terminal = require('nvim-terminal.terminal')
local Window = require('nvim-terminal.window')

local window = Window:new({
	position = 'botright',
	split = 'sp',
	width = 50,
	height = 15
})

terminal = Terminal:new(window)
```
