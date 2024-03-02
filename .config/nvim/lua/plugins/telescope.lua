return {
    "nvim-telescope/telescope.nvim",
    keys = {
        -- disable the keymap to grep files
        --{"<leader>/", false},
        -- disable the global find files
        {
            "<leader><leader>",
            false,
        },
        {
            "<leader>fp",
            function()
                require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
            end,
            desc = "Find Plugin File",
        },
        -- telescope notify history
        {
            "<leader>nh",
            function()
                require("telescope").extensions.notify.notify({
                    results_title = "Notification History",
                    prompt_title = "Search Messages",
                })
            end,
            desc = "Notification History",
        },
        -- Telescope resume (last picker)
        {
            "<leader>tr",
            function()
                require("telescope.builtin").resume()
            end,
            desc = "Resume last telescope picker",
        },
        -- Telescope Commands
        {
            "<leader>tc",
            function()
                require("telescope.builtin").commands({ results_title = "Commands Results" })
            end,
            desc = "Telescope Commands",
        },
        -- Telescope find in buffer
        {
            "<leader>fb",
            function()
                require("telescope.builtin").current_buffer_fuzzy_find()
            end,
        },
        -- Telescope show keymaps
        {
            "<leader>tk",
            function()
                require("telescope.builtin").keymaps({ results_title = "Key Maps Results" })
            end,
        },
        -- Telescope help
        {
            "<leader>th",
            function()
                require("telescope.builtin").help_tags({ results_title = "Help Results" })
            end,
        },
        {
            "<leader>ff",
            function()
                require("telescope.builtin").find_files()
            end,
        },
    },
}
