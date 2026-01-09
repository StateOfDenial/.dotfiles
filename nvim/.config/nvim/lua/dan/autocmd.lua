vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "format file on write",
    buffer = buffer,
    callback = function()
        vim.lsp.buf.format { async = false }
    end
})

vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "format d2 file after save and refresh",
    buffer = buffer,
    callback = function(opts)
        if vim.bo[opts.buf].filetype == "d2" then
            local cmd = string.format("d2 fmt '%s'", opts.file)
            os.execute(cmd)
            vim.api.nvim_command("e")
        end
    end
})

vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Auto detect tf files on save",
    buffer = buffer,
    callback = function(opts)
        if vim.bo[opts.buf].filetype == "tf" then
            vim.api.nvim_command("filetype detect")
        end
    end
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})
