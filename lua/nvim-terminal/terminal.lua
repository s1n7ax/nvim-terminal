local Window = require("nvim-terminal.window")

local v = vim.api
local cmd = vim.cmd

local Terminal = { bufs = {}, last_winid = nil, last_term = nil }

function Terminal:new(window, opt)
	self.window = window or Window:new()
	return self
end

function Terminal:init()
	error("There are some breaking changes!")
	error("Please check new configuration at https://github.com/s1n7ax/nvim-terminal")
end

function Terminal:open(term_number)
	term_number = term_number or 1

	local create_win = not self.window:is_valid()
	-- create buffer if it does not exist by the given term_number or the stored
	-- buffer number is no longer valid
	local create_buf = self.bufs[term_number] == nil or not v.nvim_buf_is_valid(self.bufs[term_number])

	-- window and buffer does not exist
	if create_win and create_buf then
		self.last_winid = v.nvim_get_current_win()
		self.window:create_term()
		self.bufs[term_number] = self.window:get_bufno()

		-- window does not exist but buffer does
	elseif create_win then
		self.last_winid = v.nvim_get_current_win()
		self.window:create(self.bufs[term_number])

		-- buffer does not exist but window does
	elseif create_buf then
		self.window:focus()
		cmd(":terminal")
		self.bufs[term_number] = self.window:get_bufno()

		-- buffer and window exist
	else
		local curr_term_buf = self.bufs[term_number]
		local last_term_buf = self.bufs[self.last_term]

		if curr_term_buf ~= last_term_buf then
			self.window:set_buf(curr_term_buf)
		end
	end

	self.last_term = term_number
end

function Terminal:close()
	local current_winid = v.nvim_get_current_win()

	if self.window:is_valid() then
		self.window:close()

		if current_winid == self.window.winid then
			if v.nvim_win_is_valid(self.last_winid) then
				v.nvim_set_current_win(self.last_winid)
			end
		end
	end
end

function Terminal:toggle()
	self.last_term = self.last_term and self.last_term or 1

	local opened = self.window:is_valid()

	if opened then
		self:close()
	else
		self:open(self.last_term)
	end
end

return Terminal
