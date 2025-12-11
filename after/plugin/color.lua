function Theme(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)
end

Theme()
