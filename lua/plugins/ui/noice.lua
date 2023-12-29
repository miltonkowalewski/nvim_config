return
{
  "folke/noice.nvim",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
  },
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = false,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = false,
    },
    cmdline = {
      view = "cmdline_popup",
    },
  },
  keys = {
    { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c",                 desc = "Redirect Cmdline" },
    { "<leader>unl", function() require("noice").cmd("last") end,                   desc = "Noice Last Message" },
    { "<leader>unh", function() require("noice").cmd("history") end,                desc = "Noice History" },
    { "<leader>una", function() require("noice").cmd("all") end,                    desc = "Noice All" },
    { "<leader>und", function() require("noice").cmd("dismiss") end,                desc = "Dismiss All" },
  },
}
