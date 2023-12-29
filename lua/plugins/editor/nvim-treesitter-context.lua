return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  keys = {
    { "<leader>tc", ":TSContextToggle<cr>", desc = "Toggle context of virtual text" },
  }
}
