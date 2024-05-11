return {
  "stevearc/oil.nvim",
  config = function()
	require("oil").setup({
	    columns = {
		"icon",
		"permissions",
	    },
	    keymaps = {
		["<C-s>"] = false,
		["<C-t>"] = false,
		["<C-n>"] = false,
		["<C-h>"] = false,
	    },
	    view_options = {
		show_hidden = true,
	    },
	})

	vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	vim.keymap.set("n", "<leader>pl", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
