local config = require('nvim-terminal.config')
local Util = require('nvim-terminal.util')
local Terminal = require('nvim-terminal.terminal')
local Window = require('nvim-terminal.window')
local DefaultTerminal = Terminal:new(Window:new())

local api = vim.api

NTGlobal = {}

local setup = function(opts)
    config = Util.Lua.merge_tables(config, opts or {})

    if config.terminals == nil then return end

    local window = Window:new(config.window)
    local terminal = Terminal:new(window)

    NTGlobal['terminal'] = terminal
    NTGlobal['window'] = window

    local LUA_F = ':lua %s<CR>'
    local TG_F = LUA_F:format('NTGlobal["terminal"]:toggle()')
    local T_F = LUA_F:format('NTGlobal["terminal"]:open(%i)')
    local INCW_F = LUA_F:format('NTGlobal["window"]:inc_height(%i)')
    local DECW_F = LUA_F:format('NTGlobal["window"]:dec_height(%i)')

    if not config.disable_default_keymaps then
        -- setting toggle keymap
        api.nvim_set_keymap('n', config.toggle_keymap, TG_F, {silent = true})

        -- setting window height keymap
        api.nvim_set_keymap('n', config.increase_height_keymap,
                            INCW_F:format(2), {silent = true})

        -- setting window height keymap
        api.nvim_set_keymap('n', config.decrease_height_keymap,
                            DECW_F:format(2), {silent = true})

        for index, term_conf in ipairs(config.terminals) do
            -- setting terminal keymap
            api.nvim_set_keymap('n', term_conf.keymap, T_F:format(index),
                                {silent = true})
        end
    end
end

return {
    Terminal = Terminal,
    Window = Window,
    DefaultTerminal = DefaultTerminal,
    setup = setup,
}
