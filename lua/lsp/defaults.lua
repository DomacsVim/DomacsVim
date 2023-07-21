dvim.core.lspconfig = {
  keys = {
    { "gD", vim.lsp.buf.declaration },
    { "e[", vim.diagnostic.goto_prev },
    { "e]", vim.diagnostic.goto_next },
    { "[e", vim.diagnostic.goto_prev },
    { "]e", vim.diagnostic.goto_next },
    { "gd", vim.lsp.buf.definition },
    { "K", vim.lsp.buf.hover },
    { "gi", vim.lsp.buf.implementation },
    { "gs", vim.lsp.buf.signature_help },
    { "gr", vim.lsp.buf.rename },
    { "gR", vim.lsp.buf.references },
    { "gca", vim.lsp.buf.code_action },
    {
      "F",
      function()
        vim.lsp.buf.format({ async = true })
      end,
    },
  },
  buffer_options = {
    omnifunc = "v:lua.vim.lsp.omnifunc",
    formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:500})",
  },
  nlsp_settings = {
    setup = {
      config_home = dvim_config_dir .. "/lsp-settings",
      append_default_schemas = true,
      ignored_servers = {},
    },
  },
  null_ls = {
    setup = {
      debug = false,
    },
    config = {},
  },
  luasnip = {},
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
      { name = "DiagnosticSignError", text = " " },
      { name = "DiagnosticSignWarn", text = " " },
      { name = "DiagnosticSignHint", text = "" },
      { name = "DiagnosticSignInfo", text = " " },
    },
  },
  installer = {
    ensure_installed = { "lua_ls" },
    automatic_installation = true,
  },
}

return dvim.core.lspconfig
