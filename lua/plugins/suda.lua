local M = {}

M.lazy = {
  "lambdalisue/suda.vim",
  cmd = { "SudaRead", "SudaWrite" },
  keys = {
    { "<leader><S-s>", ":SudaWrite<CR>", desc = "Suda Write" },
  }
}

return M
