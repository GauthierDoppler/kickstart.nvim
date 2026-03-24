return {
  {
    'dmtrKovalenko/fff.nvim',
    build = function()
      require('fff.download').download_or_build_binary()
    end,
    lazy = false,
    opts = {
      keymaps = {
        cycle_grep_modes = '<S-Tab>',
      },
      grep = {
        modes = { 'plain', 'regex', 'fuzzy' },
      },
    },
    config = function(_, opts)
      require('fff').setup(opts)

      local ok, grep_renderer = pcall(require, 'fff.grep.grep_renderer')
      if not ok or grep_renderer._blob_guard_patched then return end

      local original_render_line = grep_renderer.render_line
      grep_renderer.render_line = function(item, ctx)
        if item and type(item.line_content) == 'string' then
          -- NUL bytes trigger Vim:E976 in strdisplaywidth (treated as Blob).
          item.line_content = item.line_content:gsub('%z', ' ')
        end
        return original_render_line(item, ctx)
      end

      grep_renderer._blob_guard_patched = true

      local function get_prompt_and_query()
        local bufnr = vim.api.nvim_get_current_buf()
        local prompt = vim.fn.prompt_getprompt(bufnr) or ''
        local line = vim.api.nvim_get_current_line()
        local query = line
        if prompt ~= '' and line:sub(1, #prompt) == prompt then query = line:sub(#prompt + 1) end
        return prompt, query
      end

      -- <C-i> appends folder scope constraint: `pattern **/**` with cursor between the slashes
      local add_folder_scope = function()
        local ok_picker, picker_ui = pcall(require, 'fff.picker_ui')
        if not ok_picker or not picker_ui.state or picker_ui.state.mode ~= 'grep' then return end

        local prompt, query = get_prompt_and_query()
        if query == '' then return end

        local before_cursor = query .. ' **/'
        local after_cursor = '/**'
        vim.api.nvim_set_current_line(prompt .. before_cursor .. after_cursor)
        vim.api.nvim_win_set_cursor(0, { 1, #prompt + #before_cursor })
      end

      local fff_wrap_group = vim.api.nvim_create_augroup('fff-wrap-query', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = fff_wrap_group,
        pattern = 'fff_input',
        callback = function(args)
          local map_opts = { buffer = args.buf, noremap = true, silent = true }
          vim.keymap.set({ 'i', 'n' }, '<C-i>', add_folder_scope, map_opts)
        end,
      })
    end,
    keys = {
      { '<leader>sf', function() require('fff').find_files() end, desc = '[S]earch [F]iles' },
      { '<leader>sg', function() require('fff').live_grep() end, desc = '[S]earch by [G]rep' },
      { '<leader>sw', function() require('fff').live_grep { query = vim.fn.expand '<cword>' } end, mode = { 'n', 'v' }, desc = '[S]earch current [W]ord' },
      {
        '<leader>sW',
        function()
          local word = vim.fn.expand '<cword>'
          word = word:gsub('"', '\\"')
          require('fff').live_grep { query = string.format('"%s" ', word) }
        end,
        mode = { 'n', 'v' },
        desc = '[S]earch current [W]ord (quoted)',
      },
    },
  },
}
