return {
  'dmtrKovalenko/fff.nvim',
  build = function() require('fff.download').download_or_build_binary() end,
  lazy = true,
  keys = {
    {
      '<leader>sf',
      function() require('fff').find_files() end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>sn',
      function() require('fff').find_files_in_dir(vim.fn.stdpath 'config') end,
      desc = '[S]earch [N]eovim files',
    },
  },
  opts = {
    layout = {
      height = 0.8,
      width = 0.8,
      prompt_position = 'bottom',
      preview_position = 'right',
      preview_size = 0.5,
    },
    frecency = { enabled = true },
    history = { enabled = true },
  },
}
