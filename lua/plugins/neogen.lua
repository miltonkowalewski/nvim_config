local M = {}

M.lazy =
-- https://github.com/danymat/neogen
{
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    version = "*",
  keys = {
    { "<leader>sd", function ()
      require('neogen').generate()
    end, desc = "Neogen Doc Func, Class, Type, File" },
  }
}

return M
