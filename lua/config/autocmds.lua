-- Global autocommands
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Folding setup for selected languages
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Enable treesitter folding for Go, TS, and Ruby',
  group = vim.api.nvim_create_augroup('classic_indent_folds', { clear = true }),
  pattern = {
    'go',
    'typescript',
    'typescriptreact',
    'javascript',
    'javascriptreact',
    'ruby',
  },
  callback = function()
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 99
    vim.opt_local.foldlevelstart = 99
    vim.opt_local.foldminlines = 1
  end,
})

-- Auto-open Neo-tree when opening a directory
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Auto-open Neo-tree when opening a directory',
  group = vim.api.nvim_create_augroup('auto_open_neotree', { clear = true }),
  callback = function()
    local stats = vim.loop.fs_stat(vim.fn.argv(0))
    if stats and stats.type == 'directory' then
      require('neo-tree.command').execute({ action = 'focus', position = 'left', dir = vim.fn.argv(0) })
    end
  end,
})
