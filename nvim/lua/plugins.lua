return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim', build = 'make'
  },
  {
    'tpope/vim-commentary'
  },
  {
    'tpope/vim-surround'
  },
  {
    'tpope/vim-markdown'
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "tsx" },
        -- only applied to `ensure_installed`
        sync_install = false,
        auto_install = false,
        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        rainbow = {
          enable = true,
          extended_mode = true,
        },
      }
    end
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "williamboman/mason.nvim",
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "tpope/vim-unimpaired",
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          -- theme = 'moonfly'
          theme = 'papercolor_light'
          -- theme = 'papercolor_dark'
        },
        sections = {
          lualine_a = {
            {
              'filename',
              path = 1
            }
          }
        }
      })
    end
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require("null-ls")
      -- local config_file = "~/Documents/projects/legalZoom/my-lz/packages/config/prettier.default.js"
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettierd.with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "html", "json",
              "markdown" },
            -- env = {
            --   PRETTIERD_DEFAULT_CONFIG = vim.fn.expand(config_file)
            -- },
          })
        }
      })
    end
  }
}
