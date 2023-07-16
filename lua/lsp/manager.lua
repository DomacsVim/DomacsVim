local dvim_lsp = require("lsp")
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

local capabilities = dvim_lsp.capabilities()

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
    })
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          diagnostics = {
            globals = { "vim", "dvim" },
          },
          workspace = {
            library = {
              vim.fn.expand "$VIMRUNTIME",
              dvim_runtime_dir,
              -- require("neodev.config").types(),
              "${3rd}/busted/library",
              "${3rd}/luassert/library",
              "${3rd}/luv/library",
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    })
  end,
  ["tailwindcss"] = function()
    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
      root_dir = function(fname)
        local util = require("lspconfig/util")
        return util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.js", "tailwind.cjs")(fname)
      end,
      init_options = {
        userLanguages = {
          jsx = "javascriptreact",
          tsx = "typescriptreact",
          css = "css",
          html = "html",
        },
      },
      {
        "aspnetcorerazor",
        "astro",
        "astro-markdown",
        "blade",
        "django-html",
        "htmldjango",
        "edge",
        "eelixir",
        "elixir",
        "ejs",
        "erb",
        "eruby",
        "gohtml",
        "haml",
        "handlebars",
        "hbs",
        "html",
        "html-eex",
        "heex",
        "jade",
        "leaf",
        "liquid",
        "mdx",
        "mustache",
        "njk",
        "nunjucks",
        "php",
        "razor",
        "slim",
        "twig",
        "css",
        "less",
        "postcss",
        "sass",
        "scss",
        "stylus",
        "sugarss",
        "javascript",
        "javascriptreact",
        "jsx",
        "reason",
        "rescript",
        "typescript",
        "typescriptreact",
        "tsx",
        "vue",
        "svelte",
      },
    })
  end,
})
