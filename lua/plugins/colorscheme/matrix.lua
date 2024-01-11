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
    vim.g.matrix_borders = true
    vim.g.matrix_disable_background = true
    vim.g.matrix_italic = true

    -- Load the colorscheme
    -- require('matrix').set()
  end
}
