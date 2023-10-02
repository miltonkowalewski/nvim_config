local M = {}

M.lazy =
--  [markdown previewer]
  --  https://github.com/iamcco/markdown-preview.nvim
  --  Note: If you change the build command, wipe ~/.local/data/nvim/lazy
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    cmd = {
      "MarkdownPreview",
      "MarkdownPreviewStop",
      "MarkdownPreviewToggle",
    },
    build = "cd app && yarn install",
    keys = {
      { "<leader>0mp", mode = { "n" }, ":MarkdownPreviewToggle<CR>", desc="MarkdownPreviewToggle" },
    }
  }

return M
