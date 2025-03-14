-- lua/plugins/mini-files.lua
return {
  {
    "echasnovski/mini.files",
    version = false,  -- use latest version
    config = function()
      require("mini.files").setup({
        options = {
          use_as_default_explorer = true,  -- set as the default explorer if you prefer
        },
        windows = {
          preview = true,  -- enable file preview in the explorer window
        },
      })
    end,
    keys = {
      { "<leader>mf", function() require("mini.files").open() end, desc = "Mini Files Explorer" },
    },
  },
}

