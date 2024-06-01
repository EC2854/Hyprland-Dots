return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
	config = function()
		require("silicon").setup({
            font = "JetbrainsMono Nerd Font=34;Noto Color Emoji=34",
            theme = "gruvbox-dark",
            background = "#1D2021",
            no_window_controls = true,
		})
	end
}
