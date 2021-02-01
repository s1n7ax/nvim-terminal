
local v = vim.api

local Terminal = {
	bufs = {},
	last_winid = nil,
	last_term = nil,
}

function Terminal:new(window, opt)
	self.window = window and window or Window:new()
	return self
end

function Terminal:init()
	error("There are some breaking changes!")
	error("Please check new configuration in https://github.com/s1n7ax/nvim-terminal")
end

function Terminal:open(term_number)
	local create_win = not self.window:is_valid()
	local create_buf = self.bufs[term_number] == nil

	self.last_term = term_number


	if create_win and create_buf then
		self.window:create_term()
		table.insert(self.bufs, self.window:get_bufno())
		return
	end

	if create_win then
		self.window:create(self.bufs[term_number])
		return
	end

	if create_buf then
		self.window:focus()
		vim.cmd(':terminal')
		return
	end
end

function Terminal:close()
	if self.window:is_valid() then
		self.window:close()
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
