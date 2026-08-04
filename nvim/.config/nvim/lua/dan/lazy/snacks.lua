return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        input = { enabled = true },
        picker = {
            enabled = true,
            win = {
                input = {
                    keys = {
                        ["<A-a>"] = { "opencode_send", mode = { "n", "i" } },
                    },
                },
            },
            actions = {
                opencode_send = function(picker) ---@param picker snacks.Picker
                    local items = vim.tbl_map(function(item) ---@param item snacks.picker.Item
                        return item.file
                            and require("opencode").format({ path = item.file, from = item.pos, to = item.end_pos })
                            or item.text
                    end, picker:selected({ fallback = true }))

                    require("opencode").prompt(table.concat(items, ", ") .. " ")
                end,
            },
        },
    },
}
