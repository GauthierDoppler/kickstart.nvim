-- Global keymaps and diagnostics
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Window management
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = '[W]indow focus left' })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = '[W]indow focus down' })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = '[W]indow focus up' })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = '[W]indow focus right' })
vim.keymap.set('n', '<leader>ws', '<cmd>split<CR>', { desc = '[W]indow [S]plit horizontal' })
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<CR>', { desc = '[W]indow [V]split vertical' })
vim.keymap.set('n', '<leader>wq', '<cmd>close<CR>', { desc = '[W]indow [Q]uit' })
vim.keymap.set('n', '<leader>ww', '<C-w>w', { desc = '[W]indow cycle next' })

-- Buffer management
vim.keymap.set('n', '<leader>bq', function() require('mini.bufremove').delete(0) end, { desc = '[B]uffer [Q]uit' })
vim.keymap.set('n', '<leader>bn', '<cmd>BufferLineCycleNext<CR>', { desc = '[B]uffer [N]ext' })
vim.keymap.set('n', '<leader>bp', '<cmd>BufferLineCyclePrev<CR>', { desc = '[B]uffer [P]revious' })
vim.keymap.set('n', '<leader>bQ', function()
  local bufremove = require 'mini.bufremove'
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= 'neo-tree' then
      bufremove.delete(buf)
    end
  end
end, { desc = '[B]uffer [Q]uit all' })

-- Copy file path
vim.keymap.set('n', '<leader>cp', function() vim.fn.setreg('+', vim.fn.expand '%:~:.') end, { desc = '[C]opy relative [P]ath' })
vim.keymap.set('n', '<leader>cP', function() vim.fn.setreg('+', vim.fn.expand '%:p') end, { desc = '[C]opy full [P]ath' })
