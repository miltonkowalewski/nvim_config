return {
  'iruzo/matrix-nvim',
  config = function()
    require('lualine').setup {
      options = {
        theme = 'matrix'
      }
    }

    -- Example config in lua
    -- vim.g.matrix_contrast = true
    -- vim.g.matrix_borders = false
    vim.g.matrix_disable_background = false
    -- vim.g.matrix_italic = false

    -- Load the colorscheme
    -- require('matrix').set()
  end
}
