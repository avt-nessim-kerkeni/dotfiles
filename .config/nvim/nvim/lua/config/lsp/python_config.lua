local function setup(lsp_config, get_root_dir)
    -- Function to find the nearest poetry environment within the root directory
    local function find_poetry_env(root_dir)
        local poetry_lock_path = vim.fn.glob(root_dir .. "/**/poetry.lock", true, true)[1]
        if poetry_lock_path and vim.fn.filereadable(poetry_lock_path) == 1 then
            local poetry_env = vim.fn.systemlist("cd " .. vim.fn.shellescape(vim.fn.fnamemodify(poetry_lock_path, ":h")) .. " && poetry env info -p")[1]
            if poetry_env and poetry_env ~= "" then
                vim.notify("Found Poetry env: " .. poetry_env, vim.log.levels.INFO)
                return poetry_env .. "/bin/python"
            end
        end
        return nil
    end

    local function get_python_path()
        -- Get the root directory
        local root_dir = get_root_dir(true)
        -- Find Poetry environment within the root directory
        local python_path = find_poetry_env(root_dir) or vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
        return python_path
    end

    lsp_config.pyright.setup({
        before_init = function(_, config)
            local python_path = get_python_path()
            config.settings.python.pythonPath = python_path
        end,
        root_dir = get_root_dir,
        single_file_support = true
    })
end

return { setup = setup }
