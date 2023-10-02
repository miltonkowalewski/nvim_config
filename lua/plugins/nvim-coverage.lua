local M = {}

local function coverage_autorun ()
  if vim.env.VIRTUAL_ENV then
    vim.api.nvim_exec('2TermExec cmd="coverage lcov" dir=~/<my-repo-path>', false)
  end
end

M.lazy =
--  Shows a float panel with the [code coverage]
--  https://github.com/andythigpen/nvim-coverage
--
--  Your project must generate coverage/lcov.info for this to work.
--
--  On jest, make sure your packages.json file has this:
--  "tests": "jest --coverage"
--
--  If you use other framework or language, refer to nvim-coverage docs:
--  https://github.com/andythigpen/nvim-coverage/blob/main/doc/nvim-coverage.txt
{
  "andythigpen/nvim-coverage",
  event = "User BaseFile",
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = {
    "Coverage",
    "CoverageLoad",
    "CoverageLoadLcov",
    "CoverageShow",
    "CoverageHide",
    "CoverageToggle",
    "CoverageClear",
    "CoverageSummary",
  },
  config = function()
    require("coverage").setup()
    -- vim.api.nvim_create_autocmd("BufWritePost", {
    --   callback = coverage_autorun,
    -- })
  end,
  requires = { "nvim-lua/plenary.nvim" },
}

return M
