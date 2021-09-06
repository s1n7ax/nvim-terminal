local config = require('nvim-terminal.config')
local Util = require('nvim-terminal.util')
local Terminal = require('nvim-terminal.terminal')
local Window = require('nvim-terminal.window')
local DefaultTerminal = Terminal:new(Window:new())
local S = Util.String

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
    local HEIGHTC_F = LUA_F:format('NTGlobal["window"]:change_height(%i)')
    local WIDTHC_F = LUA_F:format('NTGlobal["window"]:change_width(%i)')

    if not config.disable_default_keymaps then
        -- setting toggle keymap
        if S.is_not_empty(config.toggle_keymap) then
            api.nvim_set_keymap('n', config.toggle_keymap, TG_F, {silent = true})
        end

        -- setting window width keymap
        if S.is_not_empty(config.increase_width_keymap) then
            api.nvim_set_keymap('n', config.increase_width_keymap,
                                WIDTHC_F:format(
                                  config.window_width_change_amount),
                                {silent = true})
        end

        -- setting window width keymap
        if S.is_not_empty(config.decrease_width_keymap) then
            api.nvim_set_keymap('n', config.decrease_width_keymap,
                                WIDTHC_F:format(
                                  -config.window_width_change_amount),
                                {silent = true})
        end

        -- setting window height keymap
        if S.is_not_empty(config.increase_height_keymap) then
            api.nvim_set_keymap('n', config.increase_height_keymap,
                                HEIGHTC_F:format(
                                  config.window_height_change_amount),
                                {silent = true})
        end

        -- setting window height keymap
        if S.is_not_empty(config.decrease_height_keymap) then
            api.nvim_set_keymap('n', config.decrease_height_keymap,
                                HEIGHTC_F:format(
                                  -config.window_height_change_amount),
                                {silent = true})
        end

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
