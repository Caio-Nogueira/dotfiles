local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    require('go.format').goimports()
  end,
  group = format_sync_grp,
})

return {
  'ray-x/go.nvim',
  dependencies = { -- optional packages
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('go').setup {
      lsp_codelens = true,
    }
  end,
  event = { 'CmdlineEnter' },
  ft = { 'go', 'gomod' },
  build = function()
    require('go.install').update_all_sync()
  end,

  vim.keymap.set('n', '<leader>gt', '<cmd>GoTestFunc<CR>'),
  vim.keymap.set('n', '<leader>gT', '<cmd>GoTest<CR>'),
  vim.keymap.set('n', '<leader>ge', '<cmd>GoIfErr<CR>'),
}
