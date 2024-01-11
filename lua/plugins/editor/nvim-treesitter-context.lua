return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufRead", "BufWinEnter", "BufNewFile" },
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  keys = {
    { "<leader>tt", ":TSContextToggle<cr>", desc = "Toggle HEAD context" },
  }
}
