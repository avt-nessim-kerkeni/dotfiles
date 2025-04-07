local function setup(lsp_config, get_root_dir)
    lsp_config.marksman.setup({
        settings = {
            marksman = {
                -- Additional settings for marksman if needed
                filetypes = { "markdown" }
            }
        },
        root_dir = get_root_dir,
        single_file_support = true
    })
end

return { setup = setup }

