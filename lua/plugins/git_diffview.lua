local M = {}

M.lazy =
-- https://github.com/sindrets/diffview.nvim
{
  "sindrets/diffview.nvim",
  cmd = "DiffviewFileHistory",
  keys = {
    { "<leader>gf", ":DiffviewFileHistory %<CR>", desc = "Diffview File" },
    { "<leader>gc", ":DiffviewClose<CR>", desc = "Diffview Close" },
  }
}

return M
