local M = {}

-- [ranger] file browser
-- https://github.com/kevinhwang91/rnvimr
-- This is NormalNvim file browser, which is only for Linux.
--
-- If you are on Windows, you have 3 options:
-- * Use neotree instead (<space>+e).
-- * Delete rnvimr and install some other file browser you like.
-- * Or enable WLS on Windows and launch neovim from there.
--   This way you can install and use 'ranger' and its dependency 'pynvim'.
M.lazy = {
    "kevinhwang91/rnvimr",
    cmd = { "RnvimrToggle" },
    init = function()
      -- vim.g.rnvimr_vanilla = 1 → Often solves issues in your ranger config.
      vim.g.rnvimr_enable_picker = 1         -- if 1, will close rnvimr after choosing a file.
      vim.g.rnvimr_ranger_cmd = { "ranger" } -- by using a shell script like TERM=foot ranger "$@" we can open terminals inside ranger.
      -- ranger keybinds are edit on program
    end,
    keys = {
      { "<leader><S-r>", "<cmd>RnvimrToggle<cr>", desc = "Ranger File Browser" },
    }
}

return M
