-- setting up mason
local servers = {
  --"sumneko_lua",
  --"clangd",
  --"pyright",
  --"jsonls",
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local handlers = require("user.plugins.lsp.handlers")

local default_opts = {
  on_attach = handlers.on_attach,
  on_exit = handlers.on_exit,
  capabilities = handlers.capabilities,
}

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

mason_lspconfig.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup(default_opts)
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["rust_analyzer"] = function ()
    local status_ok, rust_tools = pcall(require, "rust-tools")
    if not status_ok then
      return
    end
    rust_tools.setup {
      server = default_opts
    }
  end,
  ["lua_ls"] = function()
    local opts = vim.tbl_extend("force", default_opts, {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
    lspconfig.lua_ls.setup(opts)
  end,
  ["clangd"] = function()
    local opts = vim.tbl_extend("force", default_opts, {
      capabilities = {
        offsetEncoding = { "utf-16" },
      }
    })
    lspconfig.clangd.setup(opts)
  end
})
