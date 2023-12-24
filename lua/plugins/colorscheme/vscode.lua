return {
  'Mofiqul/vscode.nvim',
  config = function()
    require('vscode').setup({
      italic_comments = true,
      disable_nvimtree_bg = true,
    })
    vim.o.background = 'dark'
    require('lualine').setup({
        options = {
            theme = 'vscode',
        },
    })
  end
}
