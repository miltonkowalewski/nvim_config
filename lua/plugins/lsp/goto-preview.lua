return {
  "rmagatti/goto-preview",
  opts = {
    width = 121, -- Width of the floating window
    height = 50, -- Height of the floating window
    default_mappings = false, -- Bind default mappings
    debug = false, -- Print debug information
    opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
    post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
  },
  config = function(_, opts) require("goto-preview").setup(opts) end,
  keys = {
    {
      "gpd",
      mode = { "n", "v" },
      function() require("goto-preview").goto_preview_definition() end,
      desc = "Goto Preview Definition",
    },
    {
      "gpi",
      mode = { "n", "v" },
      function() require("goto-preview").goto_preview_implementation() end,
      desc = "Goto Preview Implementation",
    },
    {
      "gpr",
      mode = { "n", "v" },
      function() require("goto-preview").goto_preview_references() end,
      desc = "Goto Preview References",
    },
    {
      "gP",
      mode = { "n", "v" },
      function() require("goto-preview").close_all_win() end,
      desc = "Close All Preview Windows",
    },
  },
}
