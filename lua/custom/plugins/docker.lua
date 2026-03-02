return {
  {
    'crnvl96/lazydocker.nvim',
    opts = {
      window = {
        settings = {
          width = 0.9,
          height = 0.9,
        },
      },
    },
    keys = {
      { '<leader>gd', function() require('lazydocker').toggle() end, desc = 'LazyDocker' },
    },
  },
}
