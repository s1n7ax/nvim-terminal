local Term = require('nvim-term')

vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>lua Term:open_term()<cr>', {})

