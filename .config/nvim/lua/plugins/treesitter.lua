return {
    'nvim-treesitter/nvim-treesitter',
    ft = { 'c', 'cpp', 'go', 'lua', 'rust', 'python' },
    build = ':TSUpdate',
    config = function()
        require("config.treesitter_config").setup()
    end
}
