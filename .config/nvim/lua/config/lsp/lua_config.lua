local function setup(lsp_config, get_root_dir)
    lsp_config.lua_ls.setup({
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" }
                },
                workspace = {
                    checkThirdParty = false
                }
            }
        },
        root_dir = get_root_dir,
        single_file_support = true
    })
end

return { setup = setup }
