local M = {}

M.lazy =
-- https://github.com/dstein64/nvim-scrollview
{
  "dstein64/nvim-scrollview",
  event = "BufRead",
  opts = {
    excluded_filetypes = {'nerdtree'},
    current_only = true,
    base = 'buffer',
    column = 80,
    signs_on_startup = {'all'},
    diagnostics_severities = {vim.diagnostic.severity.ERROR}
  },
  options = function (_, opts)
    require('scrollview').setup(opts)
  end
}

return M
