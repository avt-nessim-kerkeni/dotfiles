return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
             "neovim/nvim-lspconfig",
             "williamboman/mason.nvim",
             "williamboman/mason-lspconfig.nvim",
             "hrsh7th/nvim-cmp",
             "hrsh7th/cmp-nvim-lsp",
             "L3MON4D3/LuaSnip",
             "onsails/lspkind.nvim"
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            local lsp_config = require("lspconfig")
            local get_root_dir = require("config.get_root_dir").get_root_dir
            -- GET Lsp Config for each language
            local lua_config = require('config.lsp.lua_config')
            local python_config = require('config.lsp.python_config')
            local php_config = require('config.lsp.php_config')
            local markdown_config = require('config.lsp.markdown_config')
            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                },
                handlers = {
                    -- Default
                    function(server_name)
                        lsp_config[server_name].setup({
                            root_dir = get_root_dir
                        })
                    end,
                    -- Lua
                    lua_ls = function()
                        -- Call the setup function from your lua_config.lua
                        lua_config.setup(lsp_config, get_root_dir)
                    end,
                    pyright = function()
                        python_config.setup(lsp_config, get_root_dir)
                    end,
                    intelephense = function()
                        php_config.setup(lsp_config, get_root_dir)
                    end,
                    marksman = function ()
                        markdown_config.setup(lsp_config, get_root_dir)
                    end
                }
            })
            lsp_zero.set_sign_icons({
                  error = "",
                  warn = "",
                  hint = "",
                  info = "",
            })
        end
    }
}
