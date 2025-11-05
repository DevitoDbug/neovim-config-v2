local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("nvchad.configs.lspconfig")

-- list of all servers configured.
lspconfig.servers = {
    "clangd",
    "gopls",
    "lua_ls",
    "ts_ls",
    "tailwindcss",
    "eslint",
    "pyright",
}

-- list of servers configured with default config.
local default_servers = { "ts_ls", "tailwindcss", "eslint", "gopls", "pyright" }

-- lsps with default config
for _, lsp in ipairs(default_servers) do
    vim.lsp.config(lsp, {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
end

-- vim.lsp.config("gopls", {
--     on_attach = function(client, bufnr)
--         client.server_capabilities.documentFormattingProvider = false
--         client.server_capabilities.documentRangeFormattingProvider = false
--         on_attach(client, bufnr)
--     end,
--     on_init = on_init,
--     capabilities = capabilities,
--     cmd = { "gopls" },
--     root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
--     settings = {
--         gopls = {
--             gofumpt = true,
--             codelenses = {
--                 gc_details = false,
--                 generate = true,
--                 regenerate_cgo = true,
--                 run_govulncheck = true,
--                 test = true,
--                 tidy = true,
--                 upgrade_dependency = true,
--                 vendor = true,
--             },
--             hints = {
--                 assignVariableTypes = true,
--                 compositeLiteralFields = true,
--                 compositeLiteralTypes = true,
--                 constantValues = true,
--                 functionTypeParameters = true,
--                 parameterNames = true,
--                 rangeVariableTypes = true,
--             },
--             analyses = {
--                 nilness = true,
--                 unusedparams = true,
--                 unusedwrite = true,
--                 useany = true,
--             },
--             usePlaceholders = false,
--             completeUnimported = true,
--             staticcheck = true,
--             directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
--             semanticTokens = true,
--         },
--     },
-- })

vim.lsp.config("clangd", {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
})

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
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})
