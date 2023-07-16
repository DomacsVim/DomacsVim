local M = {}

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

function M.capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    for _, item in ipairs(dvim.core.lspconfig.keys) do
      vim.keymap.set("n", item[1], item[2], bufopts)
    end
  end,
})

function M.setup()
  for _, sign in ipairs(dvim.core.lspconfig.diagnostics.signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  vim.diagnostic.config(dvim.core.lspconfig.diagnostics.setup)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, dvim.core.lspconfig.diagnostics.setup.float)
  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, dvim.core.lspconfig.diagnostics.setup.float)

  require("mason-lspconfig").setup(dvim.core.lspconfig.installer)
  require("lsp.manager")
end

return M

