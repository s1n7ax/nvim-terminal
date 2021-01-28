local Term = {}

-- Returns buffer information
function Term:get_buffers()
	return vim.fn.getbufinfo()
end

-- Returns true if the passed buffer is a terminal buffer
function Term:term_buf_matcher(buf_info)
	if(buf_info.name:find('term://')) then
		return true
	end

	return false
end

-- Returns table of buffer details of terminal buffers
function Term:get_term_buffers()
	local buffers = Term:get_buffers()
	local term_buffers = {}

	for _, buf_info in ipairs(buffers) do
		local buf_name = buf_info.name

		if(Term:term_buf_matcher(buf_info)) then
			table.insert(term_buffers, buf_info)
		end
	end

	return term_buffers
end

-- Returns true if the passed buffer is hidden terminal buffer
function Term:term_hidden_buf_matcher(buf_info)
	if(buf_info.hidden == 1) then
		return true
	end

	return false
end

-- Returns table of buffer details of hidden terminal buffers
function Term:get_hidden_term_buffers()
	local term_buffers = Term:get_term_buffers()
	local term_hidden_buffers = {}

	for _, buf_info in ipairs(term_buffers) do
		if(Term:term_hidden_buf_matcher(buf_info)) then
			table.insert(term_hidden_buffers, buf_info)
		end
	end

	return term_hidden_buffers
end

-- Returns window informations
function Term:get_windows ()
	return vim.fn.getwininfo()
end

-- Returns true if the window contains a terminal buffer
function Term:win_term_buf_matcher(win_info)
	if(win_info.terminal == 1) then
		return true
	end

	return false
end

-- Returns window information that has terminal buffers
function Term:get_term_buf_windows()
	local windows = Term:get_windows()
	local term_buf_windows = {}

	for _, win_info in ipairs(windows) do
		if(Term:win_term_buf_matcher(win_info)) then
			table.insert(term_buf_windows, win_info)
		end
	end

	return term_buf_windows
end

-- Opens new window bottom of tab
-- @return { number } window number
function Term:create_window(bufnr)
	local open_buf_in_split_cmd = 'botright sp +buffer\\ %d'
	print(open_buf_in_split_cmd:format(bufnr))
	vim.cmd(open_buf_in_split_cmd:format(bufnr))
	return vim.fn.winnr()
end

-- Opens new terminal window bottom of tab
-- @return { number } window number
function Term:create_term_window()
	vim.cmd('botright new +term')
	return vim.fn.winnr()
end

function Term:open_term()
	local winnr = 0

	local term_buf_windows = Term:get_term_buf_windows()
	local term_buffers = Term:get_term_buffers()

	-- IF there are no terminal windows or terminal buffers
	-- THEN creat new terminal buffer
	if(table.getn(term_buf_windows) == 0 and table.getn(term_buffers) == 0) then
		Term:create_term_window()
		return
	end

	-- IF there are no windows to show existing terminal buffers
	-- THEN create new window and open existing buffer
	if(table.getn(term_buf_windows) == 0) then
		local bufnr = term_buffers[1].bufnr
		Term:create_window(bufnr)
	end
end

return Term
