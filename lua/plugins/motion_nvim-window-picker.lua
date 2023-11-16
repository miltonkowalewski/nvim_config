local M = {}

-- https://github.com/s1n7ax/nvim-window-picker

M.lazy = {
  's1n7ax/nvim-window-picker',
  name = 'window-picker',
  event = 'VeryLazy',
  version = '2.*',
  config = function()
    require'window-picker'.setup({
      selection_chars = 'sadrftcv',
      show_prompt = false,
    })
  end,
  keys = {
    { "<leader>P", mode = { "n", "x", "o" },
      function()
        local picked_window_id = require('window-picker').pick_window({
          hint = 'floating-big-letter'
        })
        if picked_window_id then
          vim.api.nvim_set_current_win(picked_window_id)
        end
      end, desc = "Window Picker" },
  },
}
return M

