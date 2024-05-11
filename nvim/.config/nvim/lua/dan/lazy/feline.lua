return {
  "freddiehaddad/feline.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
  },
  config = function()
    local everforest = {
        bg = "#2D353B",
        fg = "#D3C6AA",
        red = "#E67E80",
        green = "#a7c080",
        skyblue = "#7FBBB3",
        cyan = "#83C092",
        black = "#232A2E",
        magenta = "#D699B6",
        orange = "#E69875",
        yellow = "#DBBC7F",
    }
    require('feline').add_theme('everforest', everforest)
    require('feline').setup({theme = 'everforest'})
    require('feline').winbar.setup()
  end
}
