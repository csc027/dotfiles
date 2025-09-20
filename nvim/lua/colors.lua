require('ayu').setup(
	{
		mirage = false,
		terminal = true,
		overrides = {
			Comment = { italic = false },
			LineNr = { fg = '#8F8D86' }
		}
	}
)
require('ayu').colorscheme()

if vim.fn.has('termguicolors') then
	vim.opt.termguicolors = true
end
