local M = {}

M.lazy = {
  "David-Kunz/gen.nvim",
  keys = {
    { "<leader>G", mode = { "n", "x" }, ":Gen<CR>", desc = "Gen AI+" },
  },
  config = function (_, opts)
    -- require('gen').model = 'mistal:instruct'
    -- require('gen').command = 'ollama run $model "$prompt"'
    require('gen').prompts =
    {
      Elaborate_Text =
        {
          prompt = "Elaborate the following text:\n$text",
          replace = true
        },
      Fix_Code =
        {
          prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
          replace = true,
          extract = "```$filetype\n(.-)```"
        },
      Generate_Google_Docstring =
        {
          prompt = "Generate a PT-BR Google Docstring for the following source code ```$filetype\n...\n```:\n```$filetype\n$text\n```",
          replace = true,
          extract = "```$filetype\n(.-)```"
        }
    }
  end
}

return M
