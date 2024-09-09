function ColorIt(color)
	-- color = color or "rose-pine"
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)
end

ColorIt()
