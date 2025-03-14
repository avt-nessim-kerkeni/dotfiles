return {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')

    telescope.setup{
      defaults = {
        -- Additional configurations can be added here
        mappings = {
            i = {
              ["<C-j>"] = require('telescope.actions').move_selection_next,
              ["<C-k>"] = require('telescope.actions').move_selection_previous,
            },
            n = {
              ["<C-j>"] = require('telescope.actions').move_selection_next,
              ["<C-k>"] = require('telescope.actions').move_selection_previous,
            },
          },
      }
    }

    -- Keymap to list all keymaps with descriptions
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'List Keymaps' })

    -- Keymap to find files by name
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })

    -- Keymap to search for text within files
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find Text' })
  end
}

