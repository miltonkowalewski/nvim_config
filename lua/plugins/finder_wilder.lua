local M = {}

M.lazy =
-- https://github.com/gelguy/wilder.nvim
{
  dependencies = {
    'romgrk/fzy-lua-native',
  },
  'gelguy/wilder.nvim',
  event = 'VeryLazy',
  opts = {
    -- https://github.com/gelguy/wilder.nvim#lua-config-experimental
    -- NOTE: For every wilder#foo() method, the wilder Lua module exposes a wilder.foo() method in Lua. All function arguments are the same and only needs to be translated to the Lua equivalent.
    modes = {':', '/', '?'},
  },
  build = ':UpdateRemotePlugins',
  config = function (_, opts)
    require("wilder").setup(opts)
    -- Disable Python remote plugin
    require("wilder").set_option('use_python_remote_plugin', 0)

    require("wilder").set_option('pipeline', {
      require("wilder").branch(
        require("wilder").cmdline_pipeline({
          fuzzy = 1,
          fuzzy_filter = require("wilder").lua_fzy_filter(),
        }),
        require("wilder").vim_search_pipeline()
      )
    })

    require("wilder").set_option('renderer', require("wilder").renderer_mux({
      [':'] = require("wilder").popupmenu_renderer({
        highlighter = require("wilder").lua_fzy_highlighter(),
        left = {
          ' ',
          require("wilder").popupmenu_devicons()
        },
        right = {
          ' ',
          require("wilder").popupmenu_scrollbar()
        },
      }),
      ['/'] = require("wilder").wildmenu_renderer({
        highlighter = require("wilder").lua_fzy_highlighter(),
      }),
    }))
  end
}

return M
