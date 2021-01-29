# nvim-terminal

Terminal plugin to open/toggle the terminal in Neovim

## How to use

### Add the plugin using *vim-plug*

```lua
Plug 's1n7ax/nvim-terminal'
```

### Add keymap

```lua
vim.api.nvim_set_keymap('n', '<space>t', '<cmd>lua require("nvim-terminal"):toggle_open_term()<cr>', {})

```lua
#### OR

```

local Terminal = require('nvim-terminal')

term = Terminal

vim.api.nvim_set_keymap('n', '<space>t', '<cmd>lua term:toggle_open_term()<cr>', {})
```

### Set window height

```lua
vim.g.term_height = 15
```
#### OR

```lua

local Terminal = require('nvim-terminal')

term = Terminal
term:init(15)
```

## Demo
![nvim-terminal demo](https://raw.githubusercontent.com/s1n7ax/nvim-terminal/main/resources/gif/nvim-terminal.gif)
