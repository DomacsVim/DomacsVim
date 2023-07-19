local M = {}

require("lsp.defaults")

function M.capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument.completion.completionItem = {
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

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    for k, v in pairs(dvim.core.lspconfig.buffer_options) do
      vim.api.nvim_buf_set_option(ev.buf, k, v)
    end
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    for _, item in ipairs(dvim.core.lspconfig.keys) do
      vim.keymap.set("n", item[1], item[2], bufopts)
    end
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, dvim.core.lspconfig.diagnostics.setup.float)
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, dvim.core.lspconfig.diagnostics.setup.float)
  end,
})

function M.setup()
  local lsp_status_ok, _ = pcall(require, "lspconfig")
  if not lsp_status_ok then
    return
  end

  for _, sign in ipairs(dvim.core.lspconfig.diagnostics.signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  pcall(function()
    require("nlspsettings").setup(dvim.core.lspconfig.nlsp_settings.setup)
  end)

  vim.diagnostic.config(dvim.core.lspconfig.diagnostics.setup)

  require("mason-lspconfig").setup(dvim.core.lspconfig.installer)

  require("lsp.manager")
end

return M

