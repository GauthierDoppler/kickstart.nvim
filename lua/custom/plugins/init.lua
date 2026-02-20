return {
  {
    'christoomey/vim-tmux-navigator',
    event = 'VeryLazy',
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        offsets = {
          { filetype = 'neo-tree', text = 'File Explorer', highlight = 'Directory', separator = true },
        },
      },
    },
  },
}
