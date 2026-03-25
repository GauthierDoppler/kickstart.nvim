-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    'antosha417/nvim-lsp-file-operations', -- LSP import updates on file rename/move
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>e', ':Neotree toggle<CR>', desc = 'File [E]xplorer toggl[e]', silent = true },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    require('lsp-file-operations').setup()
  end,
  opts = {
    hide_root_node = true,
    window = {
      width = 35,
      mappings = {
        ['<space>'] = 'none',
        ['s'] = 'none',
        ['S'] = 'none',
        ['<C-x>'] = 'open_split',
        ['<C-v>'] = 'open_vsplit',
      },
    },
    filesystem = {
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        never_show = { '.git', '.DS_Store' },
      },
      window = {
        mappings = {
          ['<bs>'] = 'none',
        },
      },
    },
  },
}
