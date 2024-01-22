return {
  'yaocccc/nvim-hl-mdcodeblock.lua',
  dependencies = { 'nvim-treesitter' },
  config = function()
    require('hl-mdcodeblock').setup({
      {
        hl_group = "MDCodeBlock", -- default highlight group
        events = {                -- refresh event
          "FileChangedShellPost",
          "Syntax",
          "TextChanged",
          "TextChangedI",
          "InsertLeave",
          "WinScrolled",
          "BufEnter",
        },
        padding_right = 4,                    -- always append 4 space at lineend
        timer_delay = 20,                     -- refresh delay(ms)
        query_by_ft = {                       -- special parser query by filetype
          markdown = {                        -- filetype
            'markdown',                       -- parser
            '(fenced_code_block) @codeblock', -- query
          },
          python = {                          -- filetype
            'markdown',                       -- parser
            '(fenced_code_block) @codeblock', -- query
          },
        },
        minumum_len = 100, -- minimum len to highlight (number | function)
        -- minumum_len = function () return math.max(math.floor(vim.api.nvim_win_get_width(0) * 0.8), 100) end
      }
    })
  end
}
