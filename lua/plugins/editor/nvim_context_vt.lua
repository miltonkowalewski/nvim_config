return {
  "andersevenrud/nvim_context_vt",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    { "<leader>tc", ":TSContextToggle<cr>", desc = "Toggle virtual text at the end of context" },
  }
}
