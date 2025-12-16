function Theme(color)
	-- Available nightfox variants: dayfox, nightfox, dawnfox, duskfox, nordfox, terafox, carbonfox
	color = color or 'nordfox'
	local ok, err = pcall(vim.cmd.colorscheme, color)
	if not ok then
		vim.notify(err, vim.log.levels.WARN)
		-- Fallback to a default colorscheme
		pcall(vim.cmd.colorscheme, 'default')
	end
end

Theme()
