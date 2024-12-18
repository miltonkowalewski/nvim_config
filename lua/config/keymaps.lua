local M = {}

M.vim = function()
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- Better up/down
  vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
  vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  vim.keymap.set("n", "<PageUp>", "<C-u><cr>", { desc = "Up half page" })
  vim.keymap.set("n", "<PageDown>", "<C-d><cr>", { desc = "Down half page" })

  vim.keymap.set("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
  vim.keymap.set("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

  -- Move to window using the <ctrl> arrow keys
  vim.keymap.set("n", "<S-Left>", "<C-w>h", { desc = "Go to left window" })
  vim.keymap.set("n", "<S-Down>", "<C-w>j", { desc = "Go to lower window" })
  vim.keymap.set("n", "<S-Up>", "<C-w>k", { desc = "Go to upper window" })
  vim.keymap.set("n", "<S-Right>", "<C-w>l", { desc = "Go to right window" })

  -- Resize window using <ctrl> arrow keys
  vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
  vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
  vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
  vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
  vim.keymap.set("n", "<leader>8", "<cmd>vertical resize 80<cr>", { desc = "Window v resize 80" })
  vim.keymap.set("n", "<leader>1", "<cmd>vertical resize 120<cr>", { desc = "Window v resize 120" })

  -- Move Lines
  vim.keymap.set("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move down" })
  vim.keymap.set("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move up" })
  vim.keymap.set("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
  vim.keymap.set("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
  vim.keymap.set("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
  vim.keymap.set("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

  -- Buffers
  vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Prev buffer" })

  vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
  vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
  vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

  -- Clear search with <esc>
  vim.keymap.set(
    { "i", "n" },
    "<esc>",
    "<cmd>:lua vim.lsp.buf.clear_references()<cr><cmd>noh<cr><esc>",
    { desc = "Escape and clear hlsearch" }
  )

  -- Select a word
  vim.keymap.set(
    { "n", "x" },
    "<2-LeftMouse>",
    "<cmd>:lua vim.lsp.buf.clear_references()<cr><cmd>:lua vim.lsp.buf.document_highlight()<cr>viw",
    { desc = "Search word under pointer" }
  )

  -- Select all text
  vim.keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" }) -- norm! ggVG

  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
  vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
  vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
  vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
  vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
  vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

  -- Add undo break-points
  vim.keymap.set("i", ",", ",<c-g>u")
  vim.keymap.set("i", ".", ".<c-g>u")
  vim.keymap.set("i", ";", ";<c-g>u")

  -- Save file
  vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

  -- Better indenting
  vim.keymap.set({ "n", "v" }, "<S-tab>", "<gv")
  vim.keymap.set({ "n", "v" }, "<tab>", ">gv")

  -- New file
  vim.keymap.set("n", "<C-n>", "<cmd>enew<cr>", { desc = "New File" })

  -- Quit
  vim.keymap.set("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit (:q)" })

  -- Floating terminal
  vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

  -- Windows
  vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
  vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
  -- vim.keymap.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
  -- vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
  vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
  vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right" })
  vim.keymap.set("n", "<leader>=", "<C-W>=", { desc = "Equalize all windows" })

  -- Tabs
  vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
  vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
  vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
  vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
  vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
  vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

  -- Quicklist
  vim.keymap.set("n", "<leader>cr", ":cfdo %s/1/2/gce | update", { desc = "Quicklist Replace" })

  -- Toggle
  vim.keymap.set("n", "<leader>tr", ":set relativenumber!<cr>", { desc = "Toggle Relative Number" })
  vim.keymap.set("n", "<leader>tw", ":set wrap!<cr>", { desc = "Toggle Word Wrap" })

  -- Search
  vim.keymap.set("n", "*", "*``", { desc = "Search" })
end

return M
