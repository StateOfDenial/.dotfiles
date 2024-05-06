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
