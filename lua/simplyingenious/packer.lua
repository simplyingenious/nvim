return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use("TimUntersberger/neogit")

  -- TJ created lodash of neovim
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-telescope/telescope.nvim")

  use('neovim/nvim-lspconfig')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/nvim-cmp')
  use('L3MON4D3/LuaSnip')
  use('saadparwaiz1/cmp_luasnip')
  use('kylechui/nvim-surround')
  use('windwp/nvim-autopairs')
  use('numToStr/Comment.nvim')
  use('jose-elias-alvarez/null-ls.nvim')
  use('MunifTanjim/prettier.nvim')
  use('lewis6991/gitsigns.nvim')
  use('editorconfig/editorconfig-vim')
  use('norcalli/nvim-colorizer.lua')
  use('windwp/nvim-ts-autotag')

  -- color schemes
  use 'ellisonleao/gruvbox.nvim'
  use 'Mofiqul/dracula.nvim'

  use("nvim-treesitter/nvim-treesitter", {
    run = ":TSUpdate"
  })
end)

