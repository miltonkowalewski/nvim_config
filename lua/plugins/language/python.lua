return {
  'AckslD/swenv.nvim',
  ft = { "python" },
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    {
      'stevearc/dressing.nvim',
      opts = {},
    },
  },
  config = function()
    require('swenv').setup({
      -- Should return a list of tables with a `name` and a `path` entry each.
      -- Gets the argument `venvs_path` set below.
      -- By default just lists the entries in `venvs_path`.
      get_venvs = function(venvs_path)
        return require('swenv.api').get_venvs(venvs_path)
      end,
      -- Path passed to `get_venvs`.
      venvs_path = vim.fn.expand('~/venvs'),
      -- Something to do after setting an environment, for example call vim.cmd.LspRestart
      post_set_venv = function()
        vim.cmd.LspRestart()
        vim.notify('Python Virtual Environment Set', vim.log.levels.INFO, { title = 'swenv.nvim' })
      end,
    })
    require('swenv.api').auto_venv()
  end,
  keys = {
      { "<leader>pvp", function() require('swenv.api').pick_venv() end, mode = "n", desc = "Pick Python Virtual Environment"},
  }
}
