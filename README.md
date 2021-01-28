# nvim-terminal

Terminal plugin to open/toggle the terminal in Neovim

## How to use

* Add the plugin
*vim-plug*
Plug 's1n7ax/nvim-terminal'
* Add keymap
```
vim.api.nvim_set_keymap('n', '<space>t', '<cmd>lua require("nvim-terminal"):toggle_open_term()<cr>', {} )
```

## Demo
![nvim-terminal demo](https://raw.githubusercontent.com/s1n7ax/nvim-terminal/main/resources/gif/nvim-terminal.gif)
