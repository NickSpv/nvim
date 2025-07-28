require('nvim-treesitter.configs').setup({
  -- Автоматическая установка парсеров
  ensure_installed = {
    "lua",
    "python",
    "javascript",
    "typescript",
    "html",
    "css",
    "json",
    "bash",
    "markdown",
    "vim",
    "gitignore"
  },

  -- Рекомендуемые настройки для стабильности
  sync_install = false,
  auto_install = true,
  ignore_install = {},  -- Список парсеров для игнорирования

  -- Основные модули
  highlight = {
    enable = true,
    disable = function(lang, buf)
      -- Отключаем для больших файлов
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end

      -- Отключаем для neo-tree
      if vim.bo[buf].filetype == "neo-tree" then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,  -- Важно для производительности
  },

  -- Дополнительные модули (можно включить по необходимости)
  indent = {
    enable = false,  -- Лучше отключить, может вызывать проблемы
  },
  incremental_selection = {
    enable = false,
  },
  textobjects = {
    enable = false,
  },

  -- Настройки для работы с neo-tree
  matchup = {
    enable = false,  -- Может конфликтовать с neo-tree
  },
  context_commentstring = {
    enable = false,
  }
})
