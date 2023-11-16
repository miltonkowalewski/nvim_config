local M = {}

-- https://github.com/elentok/format-on-save.nvim
M.lazy = {
  "elentok/format-on-save.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function ()
    local formatters = require("format-on-save.formatters")

    local error_notifier = {
      show = function(opts)
        -- use opts.title and opts.body
      end,
      hide = function()
        -- hide the error when it's been resolved
      end,
    }

    require("format-on-save").setup({
      experiments = {
        partial_update = 'diff', -- or 'line-by-line'
      },
      exclude_path_patterns = {
        "/node_modules/",
        "/.venv/",
      },
      formatter_by_ft = {
        python = {
          formatters.remove_trailing_whitespace,
          formatters.if_file_exists({
            pattern = { "pyproject.toml" },
            formatter = formatters.shell({
              cmd = { "black", "--config", "pyproject.toml", "--stdin-filename", "%", "--quiet", "-" },
              expand_executable = false,
            }),
          })
        },
        lua = {
          formatters.remove_trailing_whitespace,
        },
      },
      error_notifier = error_notifier,
    })
  end
}

return M
