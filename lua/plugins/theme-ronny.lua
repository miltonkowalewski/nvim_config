local M = {}

M.lazy =
-- https://github.com/judaew/ronny.nvim
{
  "judaew/ronny.nvim",
  lazy = false,
  priority = 1000,
  -- config = function()
  --   require("ronny").setup({
  --     display = {
  --       -- Enable original Monokai colors
  --       monokai_original  = false,
  --       -- Highlight only LineNr (current line number) for cursorline
  --       -- option. This also enables cursorline (:set cursorline)
  --       only_CursorLineNr = true,
  --       -- Highlight LineNr for relativenumbers. This also enables
  --       -- relativenumbers option (:set relativenumbers)
  --       hi_relativenumber = false,
  --       -- Highlight unfocused windows when using :split or :vsplit
  --       hi_unfocus_window = false,
  --       -- Highlight formatted @text (e.g., italic, strong) in yellow
  --       -- in addition to font attributes to make the text more visible
  --       hi_formatted_text = true
  --     }
  --   })
  -- end,
}

M.load = function ()
  vim.cmd.colorscheme("ronny")
end

return M
