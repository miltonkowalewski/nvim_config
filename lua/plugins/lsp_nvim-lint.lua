local M = {}

M.lazy =
-- https://github.com/mfussenegger/nvim-lint
{
    "mfussenegger/nvim-lint",
    ft = { "php" },
    config = function()
      require('lint').linters_by_ft = {
        php = {'phpstan'},
      }
      require("lint").try_lint()
    end
}

return M
