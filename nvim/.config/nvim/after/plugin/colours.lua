--[[require('nightfox').setup({
    options = {
        transparent = true,
    },
    palettes = {},
    specs = {},
    groups = {},
})
]]

--vim.cmd("colorscheme nightfox")

require("everforest").setup({
    background = "soft",
    transparent_background_level = 0,
    ui_contrast = "low"
})

vim.cmd([[colorscheme everforest]])