return {
    "aweis89/ai-terminals.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
        terminals = {
            gemini = { cmd = "gemini" },
        },
    },
    config = function(_, opts)
        require("ai-terminals").setup(opts)

        local ai = require("ai-terminals")

        -- Toggle terminal (sends visual selection if active)
        vim.keymap.set({ "n", "v" }, "<leader>ai", function() ai.toggle("opencode") end,
            { desc = "Opencode: Toggle terminal" })

        -- Send diagnostics
        vim.keymap.set({ "n", "v" }, "<leader>ad", function() ai.send_diagnostics("opencode") end,
            { desc = "Opencode: Send diagnostics" })

        -- Add current file
        vim.keymap.set("n", "<leader>al", function()
            ai.add_files_to_terminal("opencode", { vim.fn.expand("%") })
        end, { desc = "Opencode: Add current file" })

        -- Add all buffers
        vim.keymap.set("n", "<leader>aL", function() ai.add_buffers_to_terminal("opencode") end,
            { desc = "Opencode: Add all buffers" })

        -- Run command and send output
        vim.keymap.set("n", "<leader>ar", function() ai.send_command_output("opencode") end,
            { desc = "Opencode: Run command and send output" })

        -- Add comment for background execution
        vim.keymap.set("n", "<leader>ac", function() ai.comment("opencode") end,
            { desc = "Opencode: Add comment for AI to address" })
    end,
}
