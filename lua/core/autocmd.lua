vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.c", "*.h", "*.cpp", "*.hpp" },
	command = ":setlocal tabstop=2 shiftwidth=2 expandtab",
})
