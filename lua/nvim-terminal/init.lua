local config = require("nvim-terminal.config")
local Util = require("nvim-terminal.util")
local Terminal = require("nvim-terminal.terminal")
local Window = require("nvim-terminal.window")
local DefaultTerminal = Terminal:new(Window:new())
local S = Util.String

NTGlobal = {}

local setup = function(opts)
	config = Util.Lua.merge_tables(config, opts or {})

	if config.terminals == nil then
		return
	end

	local window = Window:new(config.window)
	local terminal = Terminal:new(window)

	NTGlobal["terminal"] = terminal
	NTGlobal["window"] = window

	if not config.disable_default_keymaps then
		-- setting toggle keymap
		if S.is_not_empty(config.toggle_keymap) then
			vim.keymap.set("n", config.toggle_keymap, function()
				NTGlobal["terminal"]:toggle()
			end, { silent = true, desc = "Toggle terminal" })
		end

		-- setting window width keymap
		if S.is_not_empty(config.increase_width_keymap) then
			vim.keymap.set("n", config.increase_width_keymap, function()
				NTGlobal["window"]:change_width(config.window_width_change_amount)
			end, { silent = true, desc = "Increase terminal width" })
		end

		-- setting window width keymap
		if S.is_not_empty(config.decrease_width_keymap) then
			vim.keymap.set("n", config.decrease_width_keymap, function()
				NTGlobal["window"]:change_width(-config.window_width_change_amount)
			end, { silent = true, desc = "decrease terminal width" })
		end

		-- setting window height keymap
		if S.is_not_empty(config.increase_height_keymap) then
			vim.keymap.set("n", config.increase_height_keymap, function()
				NTGlobal["window"]:change_height(config.window_height_change_amount)
			end, { silent = true, desc = "increase terminal height" })
		end

		-- setting window height keymap
		if S.is_not_empty(config.decrease_height_keymap) then
			vim.keymap.set("n", config.decrease_height_keymap, function()
				NTGlobal["window"]:change_height(-config.window_height_change_amount)
			end, { silent = true, desc = "decrease terminal height" })
		end

		for index, term_conf in ipairs(config.terminals) do
			-- setting terminal keymap
			vim.keymap.set("n", term_conf.keymap, function()
				NTGlobal["terminal"]:open(index)
			end, { silent = true, desc = "Open terminal " .. index })
		end
	end
end

return {
	Terminal = Terminal,
	Window = Window,
	DefaultTerminal = DefaultTerminal,
	setup = setup,
}
