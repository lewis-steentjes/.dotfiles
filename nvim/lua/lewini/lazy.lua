local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
{
	'nvim-lua/plenary.nvim',	    
	'nvim-treesitter/nvim-treesitter',
	'nvim-treesitter/playground',
	'mbbill/undotree',
	'nvim-telescope/telescope.nvim', tag = '0.1.4',
	'tpope/vim-fugitive',
	'theprimeagen/harpoon',
	'ThePrimeagen/vim-be-good',
	'rose-pine/neovim', name = 'rose-pine',
})


