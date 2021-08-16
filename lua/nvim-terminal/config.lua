local config = {
    window = {position = 'botright', split = 'sp', width = 50, height = 15},

    disable_default_keymaps = false,
    toggle_keymap = '<leader>;',
    increase_height_keymap = '<leader>+',
    decrease_height_keymap = '<leader>-',

    terminals = {
        {keymap = '<leader>1'},
        {keymap = '<leader>2'},
        {keymap = '<leader>3'},
        {keymap = '<leader>4'},
        {keymap = '<leader>5'},
    },
}

return config
