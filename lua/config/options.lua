-- Function to check if a file exists
local function file_exists(path)
    local file = io.open(path, "r")
    if file then
        file:close()
        return true
    end
    return false
end

-- Define the paths
local custom_python_path = "~/venvs/neovim/bin/python"
local default_python_path = "/usr/bin/python3"

-- Check if the custom path exists, if not, set to default
if file_exists(os.getenv("HOME") .. "/venvs/neovim/bin/python") then
    vim.g.python3_host_prog = custom_python_path
else
    vim.g.python3_host_prog = default_python_path
end

local M = {}

vim.opt.listchars = {
  -- space = ".",
  eol = "↲",
  nbsp = "␣",
  trail = "·",
  precedes = "←",
  extends = "→",
  tab = "¬ ",
  conceal = "※",
}
vim.opt.list = true

M.load_default_options = function()
  local default_options = {
    autowrite = false,
    backup = false, -- creates a backup file
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 1, -- more space in the neovim command line for displaying messages
    completeopt = "menu,menuone,noselect",
    conceallevel = 0, -- so that `` is visible in markdown files
    confirm = true,
    cursorline = true, -- highlight the current line
    expandtab = true, -- convert tabs to spaces
    fileencoding = "utf-8", -- the encoding written to a file
    foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
    foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
    formatoptions = "jcroqlnt", -- tcqj
    grepprg = "rg --vimgrep",
    grepformat = "%f:%l:%c:%m",
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    laststatus = 3,
    mouse = "a", -- allow the mouse to be used in neovim
    number = true, -- set numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}
    pumheight = 10, -- pop up menu height
    relativenumber = true, -- set relative number
    ruler = false,
    scrolloff = 5, -- minimal number of screen lines to keep above and below the cursor.
    sessionoptions = { "buffers", "curdir", "folds", "globals", "help", "skiprtp", "tabpages", "winsize" },
    shiftround = true, -- Round indent
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    showcmd = false,
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    smartcase = true, -- smart case
    smarttab = true,
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    tabstop = 2, -- insert 2 spaces for a tab
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
    title = true, -- set the title of window to the value of the titlestring
    undofile = true, -- enable persistent undo
    updatetime = 100, -- faster completion
    virtualedit = "block", -- allow cursor to move where there is no text in visual block mode
    wildmode = "longest:full,full", -- change command line completion behavior
    wrap = false, -- display lines as one long line
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  }

  ---  SETTINGS  ---
  vim.opt.spelllang:append("cjk") -- disable spellchecking for asian characters (VIM algorithm does not support it)
  vim.opt.shortmess:append({ C = true, I = true, W = true, c = true })
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
