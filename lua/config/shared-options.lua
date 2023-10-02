vim.g.python3_host_prog = '/usr/bin/python3'

local M = {}

M.load_default_options = function()
	local default_options = {
    -- colorcolumn="120",
		-- statuscolumn = "%l %r",
		backup = false, -- creates a backup file
		clipboard = "unnamedplus", -- allows neovim to access the system clipboard
		cmdheight = 1, -- more space in the neovim command line for displaying messages
		completeopt = { "menuone", "noselect" },
		conceallevel = 0, -- so that `` is visible in markdown files
		fileencoding = "utf-8", -- the encoding written to a file
		foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
		foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
		guifont = "monospace:h17", -- the font used in graphical neovim applications
		hidden = true, -- required to keep multiple buffers and open multiple buffers
		hlsearch = true, -- highlight all matches on previous search pattern
		ignorecase = true, -- ignore case in search patterns
		mouse = "a", -- allow the mouse to be used in neovim
		pumheight = 10, -- pop up menu height
		showmode = false, -- we don't need to see things like -- INSERT -- anymore
		smartcase = true, -- smart case
		splitbelow = true, -- force all horizontal splits to go below current window
		splitright = true, -- force all vertical splits to go to the right of current window
		swapfile = false, -- creates a swapfile
		termguicolors = true, -- set term gui colors (most terminals support this)
		timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
		title = true, -- set the title of window to the value of the titlestring
		-- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
		undofile = true, -- enable persistent undo
		updatetime = 100, -- faster completion
		writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
		expandtab = true, -- convert tabs to spaces
		shiftwidth = 2, -- the number of spaces inserted for each indentation
		tabstop = 2, -- insert 2 spaces for a tab
		cursorline = true, -- highlight the current line
		number = true, -- set numbered lines
    relativenumber = true, -- set relative number
		numberwidth = 4, -- set number column width to 2 {default 4}
		signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
		wrap = false, -- display lines as one long line
		scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
		sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
		showcmd = false,
		ruler = false,
		laststatus = 3,
	}

	---  SETTINGS  ---
	vim.opt.spelllang:append("cjk") -- disable spellchecking for asian characters (VIM algorithm does not support it)
	vim.opt.shortmess:append("c") -- don't show redundant messages from ins-completion-menu
	vim.opt.shortmess:append("I") -- don't show the default intro message
	vim.opt.whichwrap:append("<,>,[,],h,l")

	for k, v in pairs(default_options) do
		vim.opt[k] = v
	end

	vim.filetype.add({
		extension = {
			tex = "tex",
			zir = "zir",
			cr = "crystal",
		},
		pattern = {
			["[jt]sconfig.*.json"] = "jsonc",
		},
	})
end

M.load_headless_options = function()
	vim.opt.shortmess = "" -- try to prevent echom from cutting messages off or prompting
	vim.opt.more = false -- don't pause listing when screen is filled
	vim.opt.cmdheight = 9999 -- helps avoiding |hit-enter| prompts.
	vim.opt.columns = 9999 -- set the widest screen possible
	vim.opt.swapfile = false -- don't use a swap file
end

M.load_defaults = function()
	if #vim.api.nvim_list_uis() == 0 then
		M.load_headless_options()
		return
	end
	M.load_default_options()
end

M.load_defaults()

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python", -- filetype for which to run the autocmd
	callback = function()
		-- use pep8 standards
		-- vim.opt_local.expandtab = true
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4

		-- folds based on indentation https://neovim.io/doc/user/fold.html#fold-indent
		-- if you are a heavy user of folds, consider the using nvim-ufo plugin
		-- vim.opt_local.foldmethod = "indent"

		-- automatically capitalize boolean values. Useful if you come from a
		-- different language, and lowercase them out of habit.
		vim.cmd.inoreabbrev("<buffer> true True")
		vim.cmd.inoreabbrev("<buffer> false False")

		-- in the same way, we can fix habits regarding comments or None
		vim.cmd.inoreabbrev("<buffer> // #")
		vim.cmd.inoreabbrev("<buffer> -- #")
		vim.cmd.inoreabbrev("<buffer> null None")
		vim.cmd.inoreabbrev("<buffer> none None")
		vim.cmd.inoreabbrev("<buffer> nil None")
	end,
})

return M
