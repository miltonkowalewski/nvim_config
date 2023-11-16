local M = {}

local keys = {
  { "<leader>D", mode = { "n", "v" }, "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Code Diagnostics" },
}

M.lazy = {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    keys = keys,
}

return M
