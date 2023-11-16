local M = {}

M.lazy = {
  "lambdalisue/suda.vim",
  cmd = { "SudaRead", "SudaWrite" },
  keys = {
    { "<leader>+", "<cmd>SudaWrite<cr>", desc = "Write with sudo" },
  }
}

return M
