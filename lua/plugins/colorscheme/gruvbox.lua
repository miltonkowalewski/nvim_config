return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({})
    require('lualine').setup({
        options = {
            theme = 'gruvbox_dark',
        },
    })
    vim.o.background = "dark"
  end
}
