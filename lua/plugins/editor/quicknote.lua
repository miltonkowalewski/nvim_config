return
{
  "RutaTang/quicknote.nvim", config=function()
      require("quicknote").setup({
          mode = "resident", -- "portable" | "resident", default to "portable"
          sign = "🗲", -- This is used for the signs on the left side (refer to ShowNoteSigns() api).
                      -- You can change it to whatever you want (eg. some nerd fonts icon), 'N' is default
          filetype = "md",
          git_branch_recognizable = true, -- If true, quicknote will separate notes by git branch
                                          -- But it should only be used with resident mode,  it has not effect used with portable mode
      })
  end
  , dependencies = { "nvim-lua/plenary.nvim"},
  keys = {
      { "<leader>ns", mode = { "n", "v" }, function() require('quicknote').ShowNoteSigns() end,                 desc = "Toggle Note Signs" },
      { "<leader>nn", mode = { "n", "v" }, function() require('quicknote').NewNoteAtCurrentLine() end,                 desc = "New Note" },
      { "<leader>no", mode = { "n", "v" }, function() require('quicknote').OpenNoteAtCurrentLine() end,                 desc = "Open Note" },
      { "<leader>nd", mode = { "n", "v" }, function() require('quicknote').DeleteNoteAtCurrentLine() end,                 desc = "Delete Note" },
  }
}

