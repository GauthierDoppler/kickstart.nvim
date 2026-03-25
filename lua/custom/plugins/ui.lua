return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        offsets = {
          { filetype = 'snacks_layout_box', text = 'File Explorer', highlight = 'Directory', separator = true },
        },
      },
    },
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    opts = {},
  },
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
    ft = 'markdown',
    keys = {
      { '<leader>mr', '<cmd>Markview toggle<cr>', desc = '[M]arkdown [R]ender toggle' },
    },
  },
}
