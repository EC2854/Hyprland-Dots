return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
	config = function()
		require("silicon").setup({
            font = "JetbrainsMono Nerd Font=34;Noto Color Emoji=34",
            theme = "Dracula",
            background = "#44475A",
            no_window_controls = true,
		})
	end
}
