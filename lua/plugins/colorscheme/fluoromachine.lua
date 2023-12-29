return {
  {
    'maxmx03/fluoromachine.nvim',
    config = function()
      local fm = require 'fluoromachine'
      fm.setup {
        glow = false,
        theme = require("core.lua_tools").getRandomValue({ "fluoromachine", "retrowave" })
      }
      local lualine = require 'lualine'
      lualine.setup {
        options = {
          theme = 'fluoromachine'
        }
      }
    end
  }
}
