--[[
=====================================================================
==================== OPTIMIZED NEOVIM CONFIG ====================
=====================================================================
Fast, clean, and efficient setup for MERN stack development
--]]

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Performance Optimizations ]]
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- Performance settings
vim.o.lazyredraw = false -- Don't redraw while executing macros
vim.o.ttyfast = true
vim.o.synmaxcol = 300 -- Don't highlight very long lines

-- Additional RAM optimization settings
vim.o.hidden = true -- Keep buffers in memory instead of writing to disk
vim.o.swapfile = false -- Disable swap files to reduce disk I/O
vim.o.backup = false -- Disable backup files
vim.o.writebackup = false -- Disable backup before overwriting
vim.o.maxmempattern = 2000 -- Limit memory usage for pattern matching

-- [[ Core Settings ]]
vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.confirm = true
vim.o.termguicolors = true

-- Mouse scrolling optimization
vim.o.mousescroll = 'ver:3,hor:6' -- Smooth mouse scrolling
vim.o.mousemodel = 'extend' -- Right-click extends selection

-- Sync clipboard with OS
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Clean whitespace display
vim.o.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

-- Tab settings (VS Code-like)
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true

-- [[ Key Mappings ]]
-- Clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Better tab behavior in all modes (IMPROVED VERSION)
vim.keymap.set('n', '<Tab>', '>>_', { desc = 'Indent line and move cursor' })
vim.keymap.set('n', '<S-Tab>', '_<<', { desc = 'Unindent line' })

-- Visual mode tab indentation (move curosor tooooo)
vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent and move selection' })
vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Unindent and move selection' })

-- Insert mode indentation
vim.keymap.set('i', '<S-Tab>', '<C-d>', { desc = 'Unindent in insert mode' })
vim.keymap.set('i', '<Tab>', '<C-t>', { desc = 'Indent and move forward in insert mode' })

-- Alternative: Use >> and << for more explicit indentation
vim.keymap.set('v', '>', '>gv', { desc = 'Indent and reselect' })
vim.keymap.set('v', '<', '<gv', { desc = 'Unindent and reselect' })

-- Window navigation (removed to avoid conflicts with buffer closing)
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move to right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move to upper window' })

-- Buffer navigation
vim.keymap.set('n', 'H', ':bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', 'L', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<C-w>', ':bdelete<CR>', { desc = 'Close buffer' })

-- File explorer
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })

-- Terminal mode escape
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Delete without yanking
vim.keymap.set({ 'n', 'v' }, 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true })

-- Better scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result centered' })

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix' })

-- [[ Autocommands ]]
-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Auto-close unused buffers to save RAM
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('auto-close-buffers', { clear = true }),
  callback = function()
    local buffers = vim.api.nvim_list_bufs()
    local loaded_buffers = {}
    
    for _, buf in ipairs(buffers) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted') then
        table.insert(loaded_buffers, buf)
      end
    end
    
    -- Close buffers if more than 10 are open
    if #loaded_buffers > 10 then
      local current_buf = vim.api.nvim_get_current_buf()
      for i = 1, #loaded_buffers - 8 do
        local buf = loaded_buffers[i]
        if buf ~= current_buf and not vim.api.nvim_buf_get_option(buf, 'modified') then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end
    end
  end,
})

-- [[ Plugin Manager Setup ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Plugin Configuration ]]
require('lazy').setup({
  -- File Explorer - Load immediately for instant access
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false, -- Load immediately
    priority = 900,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          highlight_diagnostics = false,
          indent_markers = {
            enable = true,
          },
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              diagnostics = false,
              modified = true,
            },
          },
        },
        filters = {
          dotfiles = false,
          git_ignored = false, -- Show git ignored files
          custom = {}, -- Don't hide any custom files
        },
        diagnostics = {
          enable = false,
          show_on_dirs = false,
          show_on_open_dirs = false,
        },
        modified = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
        hijack_cursor = false,
        hijack_netrw = false,
        update_focused_file = {
          enable = false,
        },
        git = {
          enable = true,
          show_on_dirs = false,
          show_on_open_dirs = false,
        },
      }
    end,
  },

  -- Fuzzy Finder - Load immediately for instant file finding and grep
  {
    'nvim-telescope/telescope.nvim',
    lazy = false, -- Load immediately
    priority = 800,
    keys = {
      { '<leader><leader>', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
      { '<leader>gg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
      { '<leader>bb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
      { '<leader>sw', '<cmd>Telescope grep_string<cr>', desc = 'Search word' },
      { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = 'Diagnostics' },
      { '<leader>sr', '<cmd>Telescope resume<cr>', desc = 'Resume' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          cwd = vim.fn.getcwd(),
          file_ignore_patterns = {
            -- Removed .env and other important files from ignore list
            "node_modules",
            "dist/",
            "build/",
            "*.lock",
            ".git/objects/",
            ".git/logs/",
            ".git/refs/",
          },
          -- Faster grep with ripgrep
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--glob=!.git/',
          },
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
          },
          sorting_strategy = "ascending",
          prompt_prefix = "🔍 ",
          selection_caret = "▶ ",
        },
        pickers = {
          find_files = {
            cwd = vim.fn.getcwd(),
            find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
            -- Faster file finding
            theme = "dropdown",
            previewer = false,
          },
          live_grep = {
            -- More responsive grep
            only_sort_text = true,
            theme = "ivy",
          },
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
              i = {
                ["<c-d>"] = "delete_buffer",
              }
            }
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
    end,
  },

  -- Git Integration
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      max_file_length = 40000,
      preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
    },
  },

  -- Auto Pairs & Tags
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup {
        check_ts = false,
        fast_wrap = {},
      }
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },

  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      -- Configure diagnostic display for inline errors
      vim.diagnostic.config {
        virtual_text = {
          enabled = true,
          source = 'if_many',
          prefix = '●',
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
            [vim.diagnostic.severity.INFO] = ' ',
          }
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- Additional diagnostic keymaps for better error navigation
          map('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
          map(']d', vim.diagnostic.goto_next, 'Go to next diagnostic')
          map('<leader>d', vim.diagnostic.open_float, 'Show diagnostic')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method 'textDocument/documentHighlight' then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
          end

          if client and client.supports_method 'textDocument/inlayHint' then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        html = {},
        tailwindcss = {
          filetypes = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'typescript-language-server',
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  -- Autocompletion with Enter key
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
    },
    opts = {
      keymap = {
        preset = 'enter',
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        accept = { auto_brackets = { enabled = true } },
        list = {
          max_items = 50,
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets' },
      },
      snippets = { preset = 'luasnip' },
      signature = { enabled = true },
    },
  },

  -- Formatting
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        html = { 'prettier' },
        css = { 'prettier' },
        markdown = { 'prettier' },
      },
    },
  },

  -- Clean Buffer Line
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'buffers',
          diagnostics = false,
          show_buffer_close_icons = false,
          show_close_icon = false,
          separator_style = 'thin',
          always_show_bufferline = false,
          max_name_length = 20,
          max_prefix_length = 15,
          truncate_names = true,
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              text_align = 'left',
              separator = true,
            },
          },
        },
      }
    end,
  },

  -- Theme
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        style = 'night',
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = 'transparent',
          floats = 'transparent',
        },
      }
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'html',
        'javascript',
        'typescript',
        'tsx',
        'css',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
  },

  { 'NMAC427/guess-indent.nvim', event = 'BufReadPre', opts = {} },

  -- Mini plugins for enhanced functionality
  {
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
}, {
  -- Lazy.nvim performance optimizations
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Additional Git keymaps
vim.keymap.set('n', '<leader>gb', function()
  require('gitsigns').blame_line { full = true }
end, { desc = 'Git blame line' })
vim.keymap.set('n', '<leader>gd', function()
  require('gitsigns').preview_hunk()
end, { desc = 'Preview Git diff' })

-- Transparent background
vim.api.nvim_create_autocmd(
  'ColorScheme',
  {
    pattern = '*',
    callback = function()
      local hl_groups = {
        'Normal',
        'NormalNC',
        'Comment',
        'Constant',
        'Special',
        'Identifier',
        'Statement',
        'PreProc',
        'Type',
        'Underlined',
        'Todo',
        'String',
        'Function',
        'Conditional',
        'Repeat',
        'Operator',
        'Structure',
        'LineNr',
        'NonText',
        'SignColumn',
        'CursorLine',
        'CursorLineNr',
        'StatusLine',
        'StatusLineNC',
        'EndOfBuffer',
      }
      for _, name in pairs(hl_groups) do
        vim.cmd(string.format('highlight %s ctermbg=none guibg=none', name))
      end
    end,
  }
)

-- Custom command: :Wf to format and write buffer
vim.api.nvim_create_user_command('WF', function()
  require('lazy').load { plugins = { 'conform.nvim' } }
  require('conform').format({ async = false, lsp_fallback = true })
  vim.cmd('write')
end, { desc = 'Format and write buffer' })
