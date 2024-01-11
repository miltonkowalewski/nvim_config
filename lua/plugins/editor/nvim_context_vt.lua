return {
  "andersevenrud/nvim_context_vt",
  event = { "BufRead", "BufWinEnter", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    { "<leader>tc", ":NvimContextVtToggle<cr>", desc = "Toggle END of virtual context" },
  }
}
