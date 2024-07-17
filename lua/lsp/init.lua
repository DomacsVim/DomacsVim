local log = require "utils.log"

log:TRACE "Setting up LSP support"

local lsp_status_ok, _ = pcall(require, "lspconfig")
if not lsp_status_ok then
  return
end

vim.diagnostic.config(dvim.lsp.diagnostics.setup)

for _, sign in ipairs(dvim.lsp.diagnostics.signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end

pcall(function()
  require("nlspsettings").setup(dvim.lsp.nlsp_settings.setup)
end)

require("conform").setup(dvim.lsp.formatting)

local lint = require "lint"

lint.linters_by_ft = dvim.lsp.linting.linters_by_ft

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

local function set_handler_opts_if_not_set(name, handler, opts)
  if debug.getinfo(vim.lsp.handlers[name], "S").source:find(vim.env.VIMRUNTIME, 1, true) then
    vim.lsp.handlers[name] = vim.lsp.with(handler, opts)
  end
end

set_handler_opts_if_not_set("textDocument/hover", vim.lsp.handlers.hover, { border = "rounded" })
set_handler_opts_if_not_set("textDocument/signatureHelp", vim.lsp.handlers.signature_help, { border = "rounded" })

-- Enable rounded borders in :LspInfo window.
require("lspconfig.ui.windows").default_options.border = "rounded"

require "lsp.handler"
