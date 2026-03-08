-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>e', ':Neotree reveal<CR>', desc = 'File [E]xplorer reveal', silent = true },
    { '<leader>ee', ':Neotree toggle<CR>', desc = 'File [E]xplorer toggl[e]', silent = true },
  },
  opts = {
    hide_root_node = true,
    event_handlers = {
      {
        event = 'file_opened',
        handler = function(file_path)
          local rel = vim.fn.fnamemodify(file_path, ':.')
          local bufnr = vim.fn.bufnr(file_path)
          if bufnr ~= -1 and rel ~= file_path then
            vim.api.nvim_buf_set_name(bufnr, rel)
          end
        end,
      },
    },
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
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        never_show = { '.git', '.DS_Store' },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
