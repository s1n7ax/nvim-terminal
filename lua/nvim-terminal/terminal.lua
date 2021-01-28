local Terminal = {
	width = nil,
	height = nil,
	winid = nil,
	is_winopened = false
}

-- Init Terminal object
function Terminal:init(width, height)
	self.width = width
	self.height = height
end

-- Returns buffer information
function Terminal:get_buffers()
	return vim.fn.getbufinfo()
end

-- Returns true if the passed buffer is a terminal buffer
function Terminal:term_buf_matcher(buf_info)
	if(buf_info.name:find('term://')) then
		return true
	end

	return false
end

-- Returns table of buffer details of terminal buffers
function Terminal:get_term_buffers()
	local buffers = self:get_buffers()
	local term_buffers = {}

	for _, buf_info in ipairs(buffers) do
		local buf_name = buf_info.name

		if(self:term_buf_matcher(buf_info)) then
			table.insert(term_buffers, buf_info)
		end
	end

	return term_buffers
end

-- Returns true if the passed buffer is hidden terminal buffer
function Terminal:term_hidden_buf_matcher(buf_info)
	if(buf_info.hidden == 1) then
		return true
	end

	return false
end

-- Returns table of buffer details of hidden terminal buffers
function Terminal:get_hidden_term_buffers()
	local term_buffers = self:get_term_buffers()
	local term_hidden_buffers = {}

	for _, buf_info in ipairs(term_buffers) do
		if(self:term_hidden_buf_matcher(buf_info)) then
			table.insert(term_hidden_buffers, buf_info)
		end
	end

	return term_hidden_buffers
end

-- Returns window informations
function Terminal:get_windows ()
	return vim.fn.getwininfo()
end

-- Returns true if the window contains a terminal buffer
function Terminal:win_term_buf_matcher(win_info)
	if(win_info.terminal == 1) then
		return true
	end

	return false
end

-- Returns window information that has terminal buffers
function Terminal:get_term_buf_windows()
	local windows = self:get_windows()
	local term_buf_windows = {}

	for _, win_info in ipairs(windows) do
		if(self:win_term_buf_matcher(win_info)) then
			table.insert(term_buf_windows, win_info)
		end
	end

	return term_buf_windows
end

-- Opens new window bottom of tab
-- @return { number } window number
function Terminal:create_window(bufnr)
	local open_buf_in_split_cmd = 'botright sp +buffer\\ %d'

	vim.cmd(open_buf_in_split_cmd:format(bufnr))

	local winid = vim.fn.win_getid()
	self:set_win_height(winid)

	return winid
end

-- Opens new terminal window bottom of tab
-- @return { number } window number
function Terminal:create_term_window()
	vim.cmd('botright new +term')

	local winid = vim.fn.win_getid()
	self:set_win_height(winid)

	return winid
end

function Terminal:close_window(winid)
	if(vim.api.nvim_win_is_valid(winid)) then
		vim.api.nvim_win_close(winid, false)
	end

end

function Terminal:is_win_opened(winid)
end

function Terminal:get_height()
	if(vim.g.term_height ~= nil) then
		return vim.g.term_height
	end

	if(self.height ~= nil) then
		return self.height
	end
end

-- Set window height
function Terminal:set_win_height(winnr)
	local height = self:get_height()

	if(height ~= nil) then
		vim.api.nvim_win_set_height(winnr, height)
	end
end

function Terminal:open_term()
	local term_buf_windows = self:get_term_buf_windows()
	local term_buffers = self:get_term_buffers()

	-- IF there are no terminal windows or terminal buffers
	-- THEN creat new terminal buffer
	if(table.getn(term_buf_windows) == 0 and table.getn(term_buffers) == 0) then
		self.winid = self:create_term_window()
		self.is_winopened = true
		return
	end

	-- IF there are no windows to show existing terminal buffers
	-- THEN create new window and open existing buffer
	if(table.getn(term_buf_windows) == 0) then
		local bufnr = term_buffers[1].bufnr
		self.winid = self:create_window(bufnr)
		self.is_winopened = true
	end

end

function Terminal:close_term()
	if(self.is_winopened) then
		self:close_window(self.winid)
		self.is_winopened = false
	end
end

function Terminal:toggle_open_term()
	if(self.is_winopened) then
		self:close_term()
	else
		self:open_term()
	end
end

return Terminal
