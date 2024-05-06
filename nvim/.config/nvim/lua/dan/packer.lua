-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use('ful1e5/onedark.nvim')
    use('Mofiqul/dracula.nvim')
    use('EdenEast/nightfox.nvim')
    use('neanias/everforest-nvim')
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('ThePrimeagen/refactoring.nvim')
    use {
        'ThePrimeagen/harpoon',
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('tpope/vim-obsession')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }
    use {
        'freddiehaddad/feline.nvim',
        requires = {
            { 'lewis6991/gitsigns.nvim' }
        }
    }
    use('ThePrimeagen/vim-be-good')
    use('mfussenegger/nvim-dap')
    use {
        'rcarriga/nvim-dap-ui',
        requires = {
            'mfussenegger/nvim-dap'
        }
    }
    use('leoluz/nvim-dap-go')
    use('terrastruct/d2-vim')
    use('stevearc/oil.nvim')
    use { 'Exafunction/codeium.vim',
        config = function()
            vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
                { expr = true, silent = true })
            vim.keymap.set('i', '<M-Bslash>', function() return vim.fn['codeium#Complete']() end,
                { expr = true, silent = true })
        end
    }
end)
