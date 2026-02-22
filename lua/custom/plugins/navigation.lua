return {
  {
    'christoomey/vim-tmux-navigator',
    event = 'VeryLazy',
  },
  {
    's1n7ax/nvim-window-picker',
    version = '2.*',
    opts = {
      hint = 'floating-big-letter',
      selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
      filter_rules = {
        autoselect_one = true,
        include_current_win = false,
        bo = {
          filetype = { 'neo-tree', 'notify' },
          buftype = { 'terminal', 'quickfix' },
        },
      },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = function(_, opts)
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.use_libuv_file_watcher = true
    end,
  },
}
