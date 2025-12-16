function Theme(color)
	-- Available nightfox variants: dayfox, nightfox, dawnfox, duskfox, nordfox, terafox, carbonfox
	color = color or "nordfox"
	vim.cmd.colorscheme(color)
end

Theme()
