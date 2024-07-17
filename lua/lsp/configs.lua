local M = {}

local utils = require "utils.modules"

M.defaults = {
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
      { name = "DiagnosticSignError", text = dvim.icons.ui.error },
      { name = "DiagnosticSignWarn", text = dvim.icons.ui.warn },
      { name = "DiagnosticSignHint", text = dvim.icons.ui.hint },
      { name = "DiagnosticSignInfo", text = dvim.icons.ui.info },
    },
  },
}

local function lsp_buffer_options(bufnr)
  for k, v in pairs(dvim.lsp.buffer_options) do
    vim.api.nvim_set_option_value(k, v, { buf = bufnr })
  end
end

local function lsp_buffer_keybindings(bufnr)
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }

  for mode_name, mode_char in pairs(mappings) do
    for key, remap in pairs(dvim.lsp.buffer_mappings[mode_name]) do
      local opts = { buffer = bufnr, noremap = true, silent = true }
      vim.keymap.set(mode_char, key, remap, opts)
    end
  end
end

function M.capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
  }

  return capabilities
end

function M.on_init(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

function M.on_attach(client, bufnr)
  lsp_buffer_options(bufnr)
  lsp_buffer_keybindings(bufnr)
  if client.server_capabilities["documentSymbolProvider"] then
    require("nvim-navic").attach(client, bufnr)
  end
end

return M
