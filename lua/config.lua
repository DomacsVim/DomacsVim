local M = {}

local utils = require("utils.modules")

-- return a table of default configs
function M.default_configs()
  local icons = require("icons")
  return {
    icons = icons,
    lsp = {
      linting = {
        linters_by_ft = {
          -- -- For example :
          -- javascript = { "eslint_d" }
          -- typescript = { "eslint_d" }
          -- python = { "pylint" }
        },
      },
      formatting = {
        formatters_by_ft = {
          -- -- For example :
          -- lua = { "stylua" },
          -- python = { "black" },
          -- javascript = { { "prettierd", "prettier" } },
        },
        format_on_save = {
          async = false,
          lsp_fallback = true,
          timeout_ms = 500,
        },
      },
      luasnip = {
        sources = {
          friendly_snippets = true,
        },
      },
      installer = {
        ensure_installed = { "lua_ls", "bashls" },
        automatic_installation = true,
        handlers = {},
      },
      buffer_options = {
        omnifunc = "v:lua.vim.lsp.omnifunc",
        formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:500})",
      },
      nlsp_settings = {
        setup = {
          config_home = utils.join_paths(dvim_config_dir, "lsp-settings"),
          append_default_schemas = true,
          ignored_servers = {},
        },
      },
      buffer_mappings = {
        normal_mode = {
          ["gD"] = vim.lsp.buf.declaration,
          ["e["] = vim.diagnostic.goto_prev,
          ["e]"] = vim.diagnostic.goto_next,
          ["[e"] = vim.diagnostic.goto_prev,
          ["]e"] = vim.diagnostic.goto_next,
          ["gd"] = vim.lsp.buf.definition,
          ["K"] = vim.lsp.buf.hover,
          ["gi"] = vim.lsp.buf.implementation,
          ["gs"] = vim.lsp.buf.signature_help,
          ["gr"] = vim.lsp.buf.rename,
          ["gR"] = vim.lsp.buf.references,
          ["gca"] = vim.lsp.buf.code_action,
          ["<leader>fm"] = function()
            require("conform").format { lsp_fallback = true }
          end
        },
        insert_mode = {},
        visual_mode = {},
      },
      diagnostics = {
        setup = {
          virtual_text = {
            enable = true,
            prefix = " ",
            source = "always",
          },
          update_in_insert = false,
          underline = false,
          severity_sort = true,
          float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
          },
        },
        signs = {
          { name = "DiagnosticSignError", text = icons.ui.error },
          { name = "DiagnosticSignWarn",  text = icons.ui.warn },
          { name = "DiagnosticSignHint",  text = icons.ui.hint },
          { name = "DiagnosticSignInfo",  text = icons.ui.info },
        },
      },
    },
    keys = {
      leadermap = " ",
      term_mode = {},
      insert_mode = {},
      normal_mode = {},
      visual_mode = {},
      command_mode = {},
    },
    core = {},
    lazy = {},
    plugins = {},
    colorscheme = "onedark",
  }
end

-- load default configs
function M.load_default_configs()
  local core = require("core")
  -- load default configs
  core.load_default_configs()

  local keymappings = require("keymappings")
  -- load the default keymappings
  keymappings.load_keymappings()
end

return M
