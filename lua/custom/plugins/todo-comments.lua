return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
      { '<leader>st', '<cmd>TodoTelescope<cr>', desc = '[S]earch [T]odos' },
    },
  },
}
