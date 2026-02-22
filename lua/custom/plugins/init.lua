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
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit (Repo Status)' },
    },
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
