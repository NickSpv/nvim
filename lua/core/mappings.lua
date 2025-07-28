-- Установка лидера
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local M = {}

function M.setup()
  -- Telescope
  local telescope_ok, builtin = pcall(require, 'telescope.builtin')
  
  -- Hop
  local hop_ok, hop = pcall(require, "hop")
  local directions = hop_ok and require("hop.hint").HintDirection or nil

  -- DAP
  vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })
  vim.keymap.set("n", "<leader>dr", "<cmd>DapContinue<CR>", { desc = "Start/Continue Debugging" })

  -- NeoTree
  vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle File Explorer" })
  vim.keymap.set("n", "<leader>o", "<cmd>Neotree float git_status<CR>", { desc = "Git Status (float)" })

  -- Telescope mappings
  if telescope_ok then
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
    vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Buffers" })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = "Git Branches" })
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Git Commits" })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Git Status" })
    vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = "Document Symbols" })
    vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = "References", noremap = true, silent = true })
    
    -- Улучшенный mapping для gd с проверкой типа файла
    vim.keymap.set('n', 'gd', function()
      local filetype = vim.bo.filetype
      if filetype == 'php' then
        -- Для PHP используем textDocument/definition вместо declaration
        local params = vim.lsp.util.make_position_params()
        vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
          if err then
            vim.notify("LSP error: " .. err.message, vim.log.levels.ERROR)
            return
          end
          if not result or vim.tbl_isempty(result) then
            vim.notify("Definition not found", vim.log.levels.WARN)
            return
          end
          vim.lsp.util.jump_to_location(result[1], 'utf-8')
        end)
      else
        -- Для других языков используем стандартный Telescope
        local params = vim.lsp.util.make_position_params()
        params.position_encoding = 'utf-16'
        builtin.lsp_definitions(params)
      end
    end, { desc = "Go to definition", noremap = true, silent = true })
  end

  -- Основные операции
  vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save File" })
  vim.keymap.set("n", "<leader>x", "<cmd>BufferLinePickClose<CR>", { desc = "Close Buffer" })
  vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape Insert Mode" })
  vim.keymap.set("n", "<leader>h", "<cmd>nohls--[[ e ]]arch<CR>", { desc = "Clear Search Highlight" })

  -- Навигация по вкладкам
  vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
  vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })

  -- Hop mappings (только если модуль загружен правильно)
  if hop_ok and directions then
    vim.keymap.set("n", "ff", function()
      hop.hint_words({ current_line_only = false })
    end, { desc = "Hop to word" })

    vim.keymap.set("n", "t", function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, { desc = "Hop after cursor" })

    vim.keymap.set("n", "T", function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, { desc = "Hop before cursor" })
  else
    vim.notify("Hop.nvim not configured properly", vim.log.levels.WARN)
  end

  -- Терминал
  vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Float Terminal" })
  vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Horizontal Terminal" })
  vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=40<CR>", { desc = "Vertical Terminal" })

  -- Разделение окон
  vim.keymap.set("n", "|", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
  vim.keymap.set("n", "\\", "<cmd>split<CR>", { desc = "Horizontal Split" })

  -- Форматирование
  vim.keymap.set("n", "mm", "<cmd>Neoformat<CR>", { desc = "Format File" })

  -- TODO-комментарии
  vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
  end, { desc = "Next TODO Comment" })
  vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
  end, { desc = "Previous TODO Comment" })
end

return M.setup()
