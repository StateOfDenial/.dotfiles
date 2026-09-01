return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter",
    opts = {
        ensure_installed = { "go", "lua", "vim", "query", "python", "terraform", "yaml" },
        auto_install = true,
        indent = { enable = true },
        highlight = { enable = true },
    },
    config = function(_, opts)
        require("nvim-treesitter").setup(opts)
        vim.treesitter.language.register("templ", "templ")
    end,
}
