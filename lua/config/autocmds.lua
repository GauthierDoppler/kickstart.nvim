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

-- Trigger autoread and refresh gitsigns when Neovim regains focus or a buffer is entered
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  desc = 'Check for external file changes and refresh gitsigns',
  group = vim.api.nvim_create_augroup('auto-reload-files', { clear = true }),
  callback = function()
    vim.cmd 'checktime'
    local gs = package.loaded['gitsigns']
    if gs then gs.refresh() end
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

-- Auto-save current buffer on focus lost, buffer leave, or leaving insert mode
vim.api.nvim_create_autocmd({ 'FocusLost', 'BufLeave', 'InsertLeave', 'TextChanged' }, {
  desc = 'Auto-save current buffer',
  group = vim.api.nvim_create_augroup('auto-save', { clear = true }),
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if vim.bo[buf].modified and vim.bo[buf].modifiable and vim.bo[buf].buftype == '' then
      vim.api.nvim_buf_call(buf, function() vim.cmd 'silent! w' end)
    end
  end,
})
