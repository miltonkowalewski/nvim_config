return {
  "elentok/format-on-save.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
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
        partial_update = "diff", -- or 'line-by-line'
      },
      exclude_path_patterns = {
        "/node_modules/",
        "/.venv/",
      },
      formatter_by_ft = {
        css = formatters.lsp,
        html = formatters.lsp,
        javascript = formatters.lsp,
        json = formatters.lsp,
        markdown = formatters.prettierd,
        rust = formatters.lsp,
        scss = formatters.lsp,
        sh = formatters.shfmt,
        yaml = formatters.lsp,
        python = {
          formatters.remove_trailing_whitespace,
          formatters.remove_trailing_newlines,
          formatters.if_file_exists({
            pattern = { "pyproject.toml" },
            formatter = formatters.shell({
              cmd = { "black", "--config", "pyproject.toml", "--stdin-filename", "%", "--quiet", "-" },
              expand_executable = false,
            }),
          }),
          formatters.ruff,
        },
        lua = {
          formatters.remove_trailing_whitespace,
          formatters.lsp,
        },
      },
      error_notifier = error_notifier,
      fallback_formatter = {
        formatters.remove_trailing_whitespace,
        formatters.remove_trailing_newlines,
      },
    })
  end,
}
