local M = {}

local hop_words = "sadrftcv"
local hop_numbers = "1234567890"

local keys = {
  { "s", mode = { "n", "x", "o" }, function() require("hop").hint_patterns({ keys = hop_words }) end, desc = "Hop After" },
  { "S", mode = { "n", "o", "x" }, function() require("hop").hint_patterns({ keys = hop_words }) end, desc = "Hop Before" },
  { "t", mode = { "n", "x", "o" }, function() require("hop").hint_words({ current_line_only = true, keys = hop_words }) end, desc = "Hop After" },
  { "T", mode = { "n", "o", "x" }, function() require("hop").hint_words({ current_line_only = true, keys = hop_words }) end, desc = "Hop Before" },
  { "f", mode = { "n", "x", "o" }, function() require("hop").hint_lines({ keys = hop_numbers }) end, desc = "Hop Vertical Lines" },
  { "F", mode = { "n", "o", "x" }, function() require("hop").hint_lines({ keys = hop_numbers }) end, desc = "Hop Verical Lines" },
}

-- https://github.com/phaazon/hop.nvim

M.lazy = {
    "phaazon/hop.nvim",
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require("hop").setup({
        multi_windows = true,
        keys = hop_words,
      })
    end,
    keys = keys,
}

return M
