local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "nvchad.configs.lspconfig"

-- list of all servers configured.
lspconfig.servers = {
  "html",
  "clangd",
  "gopls",
  "lua_ls",
  "ts_ls",
  "tailwindcss",
  "eslint",
  "pyright",
  "rust_analyzer",
  "bashls",
  "templ",
  "intelephense",
}

-- list of servers configured with default config.
local default_servers = { "ts_ls", "tailwindcss", "eslint", "pyright", "rust_analyzer", "bashls", "html" }

-- lsps with default config
for _, lsp in ipairs(default_servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end

-- Go configs
vim.lsp.config("gopls", {
  on_attach = function(client, bufnr)
    -- keep NvChad defaults
    on_attach(client, bufnr)

    -- Auto-organize imports on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 3000)
        for _, res in pairs(result or {}) do
          for _, action in pairs(res.result or {}) do
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
            end
          end
        end
      end,
    })

    -- Go-only: Fill struct instantly
    vim.keymap.set("n", "<leader>fs", function()
      vim.lsp.buf.code_action {
        apply = true,
        filter = function(action)
          return action.title:match "^Fill"
        end,
      }
    end, { buffer = bufnr, desc = "Go: Fill struct" })
  end,

  on_init = on_init,
  capabilities = capabilities,

  settings = {
    gopls = {
      usePlaceholders = false,
      completeUnimported = true,
      staticcheck = true,
      analyses = {
        unusedparams = true,
        nilness = true,
        unusedwrite = true,
      },
    },
  },
})

-- Templ configs
vim.lsp.config("templ", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "html", "templ" },
})

-- PHP/Blade configs
vim.lsp.config("intelephense", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "php", "blade" },
  settings = {
    intelephense = {
      files = {
        associations = { "*.php", "*.blade.php" },
      },
      stubs = {
        "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype",
        "curl", "date", "dba", "dom", "enchant", "exif", "FFI", "fileinfo",
        "filter", "fpm", "ftp", "gd", "gettext", "gmp", "hash", "iconv",
        "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta",
        "mysqli", "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO",
        "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql",
        "Phar", "posix", "pspell", "readline", "Reflection", "session",
        "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium", "SPL",
        "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem",
        "sysvshm", "tidy", "tokenizer", "xml", "xmlreader", "xmlrpc",
        "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
        "wordpress", "phpunit", "laravel",
      },
    },
  },
})

-- C/CPP shit
vim.lsp.config("clangd", {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    on_attach(client, bufnr)
  end,
  on_init = on_init,
  capabilities = capabilities,
})

-- Lua configs
vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,

  settings = {
    Lua = {
      diagnostics = {
        enable = false, -- Disable all diagnostics from lua_ls
        -- globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/love2d/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})
