return {
    "b0o/incline.nvim",
    event = "VeryLazy",
    config = function()
      require('incline').setup({
      ignore = {
        floating_wins = false,
      },
      render = function(props)
        local render = {}
        local bufname = vim.api.nvim_buf_get_name(props.buf)
        local filename = vim.fn.fnamemodify(bufname, ":t")
        local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "bold,italic" or "None"
        local filetype_icon, color = require("nvim-web-devicons").get_icon_color(filename)

        local buffer = {
            { filetype_icon, guifg = color },
            { " " },
            { filename, gui = modified },
        }

        for _, buffer_ in ipairs(buffer) do
            table.insert(render, buffer_)
        end
        return render
      end,
    })
    end
}
