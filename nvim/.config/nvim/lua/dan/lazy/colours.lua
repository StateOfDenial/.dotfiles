
return {
  {
    "neanias/everforest-nvim",
    config = function()
	require("everforest").setup({
	    background = "soft",
	    transparent_background_level = 0,
	    ui_contrast = "low"
	})
        vim.cmd([[colorscheme everforest]])
    end
  },
}

