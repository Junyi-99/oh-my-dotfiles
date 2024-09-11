return {{"neovim/nvim-lspconfig"}, {"williamboman/mason-lspconfig.nvim"}, {
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup({
            ui = {
                border = 'rounded',
                width = 0.7,
                height = 0.8,
                icons = {
                    -- package_installed = '󰺧',
                    -- package_pending = '',
                    -- package_uninstalled = '󰺭'
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        -- The order is important!
        require("mason-lspconfig").setup({
            ensure_installed = {"pyright", "lua_ls"}
        })
        require("lspconfig").lua_ls.setup({
            -- on_attach = require("lsp").common_on_attach
        })
        require("lspconfig").pyright.setup({
            -- on_attach = require("lsp").common_on_attach
        })
    end
}}
