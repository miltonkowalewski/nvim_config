local M = {}

local chatgpt_opts = function()
  return { -- agora preciso pagar e colocar a chave ai
    async_api_key_cmd = "echo <open_api_key>",
    openai_params = {
      model = "gpt-3.5-turbo",
    },
  }
end

M.lazy = {
    "dreamsofcode-io/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    opts = chatgpt_opts,
    config = function(_, opts) require("chatgpt").setup(opts) end,
}

return M
