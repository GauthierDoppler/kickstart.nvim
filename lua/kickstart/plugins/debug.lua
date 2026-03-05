return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
    'suketa/nvim-dap-ruby',
  },
  keys = {
    { '<leader>dc', function() require('dap').continue() end, desc = 'Debug: Continue / Start' },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<leader>do', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<leader>dO', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Conditional Breakpoint' },
    { '<leader>du', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
    { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Debug: Toggle REPL' },
    { '<leader>dl', function() require('dap').run_last() end, desc = 'Debug: Run Last' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Override vscode launch.json decoder to support JSONC (inline // comments)
    -- Strips comments line-by-line, skipping // inside quoted strings
    local vscode = require 'dap.ext.vscode'
    vscode.json_decode = function(str)
      local lines = {}
      for line in str:gmatch('[^\n]*') do
        local in_string = false
        local i = 1
        while i <= #line do
          local c = line:sub(i, i)
          if c == '\\' and in_string then
            i = i + 2
          elseif c == '"' then
            in_string = not in_string
            i = i + 1
          elseif not in_string and line:sub(i, i + 1) == '//' then
            line = line:sub(1, i - 1)
            break
          else
            i = i + 1
          end
        end
        table.insert(lines, line)
      end
      return vim.json.decode(table.concat(lines, '\n'))
    end

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      ensure_installed = {
        'delve',
        'js',
      },
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
        js = function(config)
          config.adapters = {
            type = 'server',
            host = '::1',
            port = '${port}',
            executable = {
              command = 'js-debug-adapter',
              args = { '${port}' },
            },
          }
          config.configurations = {
            {
              type = 'pwa-node',
              request = 'launch',
              name = 'Launch file',
              program = '${file}',
              cwd = '${workspaceFolder}',
              console = 'integratedTerminal',
            },
            {
              type = 'pwa-node',
              request = 'attach',
              name = 'Attach to process',
              processId = require('dap.utils').pick_process,
              cwd = '${workspaceFolder}',
            },
          }
          config.filetypes = { 'javascript', 'typescript' }
          require('mason-nvim-dap').default_setup(config)

          -- Alias adapter for VS Code launch.json compatibility (type: "node", "pwa-node")
          dap.adapters['pwa-node'] = dap.adapters.js
          dap.adapters['node'] = dap.adapters.js
        end,
      },
    }

    -- Breakpoint icons and colors
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreak', numhl = 'DapBreak' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '⊜', texthl = 'DapBreak', numhl = 'DapBreak' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '⊘', texthl = 'DapBreak', numhl = 'DapBreak' })
    vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DapBreak', numhl = 'DapBreak' })
    vim.fn.sign_define('DapStopped', { text = '⭔', texthl = 'DapStop', numhl = 'DapStop' })

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.4 },
            { id = 'breakpoints', size = 0.2 },
            { id = 'stacks', size = 0.2 },
            { id = 'watches', size = 0.2 },
          },
          size = 40,
          position = 'right',
        },
        {
          elements = {
            { id = 'repl', size = 0.5 },
            { id = 'console', size = 0.5 },
          },
          size = 10,
          position = 'bottom',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = function() pcall(dapui.close) end
    dap.listeners.before.event_exited['dapui_config'] = function() pcall(dapui.close) end

    require('dap-go').setup {
      delve = {
        detached = vim.fn.has 'win32' == 0,
      },
    }

    require('dap-ruby').setup()
  end,
}
