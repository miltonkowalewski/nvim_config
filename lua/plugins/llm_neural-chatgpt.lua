local M = {}

M.lazy =
--  ARTIFICIAL INTELIGENCE  -------------------------------------------------
  --  neural [chatgpt code generator]
  --  https://github.com/dense-analysis/neural
  {
    "dense-analysis/neural",
    cmd = { "Neural" },
    config = function()
      require("neural").setup {
        source = {
          openai = {
            api_key = vim.env.OPENAI_API_KEY,
          },
        },
        ui = {
          prompt_icon = "»",
        },
      }
    end,
  }

return M
