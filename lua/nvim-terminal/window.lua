local v = vim.api

local Window = {}

function Window:new(opt)
	opt = opt and opt or {}
	
	self.pos = opt.pos and opt.pos or 'botright'
	self.split = opt.split and opt.split or 'sp'
	self.width = opt.width and opt.width or nil
	self.height = opt.height and opt.height or nil

	return self
end

-- Opens new window bottom of tab
-- @return { number } window id
function Window:create(bufnr)
	local cmd = '%s %s +buffer\\ %d'
	vim.cmd(cmd:format(self.pos, self.split, bufnr))

	self.winid = vim.fn.win_getid()

	self:update_size()

	return self.winid
end

-- Opens new terminal window bottom of tab
-- @return { number } window number
function Window:create_term()
	local cmd = '%s new +term'
	vim.cmd(cmd:format(self.pos))

	self.winid = vim.fn.win_getid()

	self:update_size()

	return self.winid
end

-- Set window width to self.width
function Window:update_size()
	if self.width ~= nil then
		v.nvim_win_set_width(self.winid, self.width)
	end

	if self.height ~= nil then
		v.nvim_win_set_height(self.winid, self.height)
	end
end


-- close the window
function Window:close(winid)
	if self:is_valid() then
		v.nvim_win_close(self.winid, false)
	end
end

-- Returns the validity of the window
-- @return { boolean } window is valid or not
function Window:is_valid()
	if(self.winid == nil) then
		return false
	end

	return v.nvim_win_is_valid(self.winid)
end

function Window:set_buf(bufno)
	return v.nvim_win_set_buf(bufno)
end

function Window:focus()
	v.nvim_set_current_win(self.winid)
end

-- Returns the buffer number
-- @return { number } buffer number
function Window:get_bufno()
	if self:is_valid() then
		return v.nvim_win_get_buf(self.winid)
	end
end

return Window
