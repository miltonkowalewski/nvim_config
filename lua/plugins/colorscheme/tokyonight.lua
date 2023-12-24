return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    style = "night"
    require("tokyonight").setup({
      style = style,
    })
    require('lualine').setup {
      options = {
        theme = 'tokyonight'
      }
    }
  end
}
