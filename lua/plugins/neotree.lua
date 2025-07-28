vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- Настройка диагностических иконок (ваша текущая версия правильная)
vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})

require("neo-tree").setup({
  close_if_last_window = false,
  enable_git_status = true,
  enable_diagnostics = true,
  filesystem = {
    hijack_netrw_behavior = "open_default",
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = false,
    },
  },
  window = {
    position = "left",
    width = 30,
    mappings = {
      ["<space>"] = "none",  -- Отключаем конфликтующие маппинги
    }
  }
})
