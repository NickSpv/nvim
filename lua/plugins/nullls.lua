local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")  -- Добавляем хелперы

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Проверка доступности бинарных утилит
local function check_formatter_available(formatter)
  return vim.fn.executable(formatter) == 1
end

null_ls.setup({
  debug = true,  -- Временно включаем debug для диагностики
  sources = {
    -- JavaScript/TypeScript
    check_formatter_available("eslint_d") and null_ls.builtins.formatting.eslint_d.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      },
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.json" })
      end,
    }) or nil,

    -- Lua
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    }),

    -- C/C++
    check_formatter_available("clang-format") and null_ls.builtins.formatting.clang_format or nil,

    -- Rust
    check_formatter_available("rustfmt") and null_ls.builtins.formatting.rustfmt or nil,

    -- Универсальные форматтеры
    null_ls.builtins.formatting.prettierd.with({
      filetypes = {
        "css", "scss", "less",
        "html", "json", "jsonc",
        "yaml", "markdown", "markdown.mdx",
        "graphql", "handlebars"
      },
      disabled_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- Добавляем обработку ошибок
          local ok, err = pcall(function()
            vim.lsp.buf.format({
              bufnr = bufnr,
              filter = function(client_)
                return client_.name == "null-ls"
              end,
              timeout_ms = 5000  -- Увеличиваем таймаут
            })
          end)
          
          if not ok then
            vim.notify("Formatting error: " .. tostring(err), vim.log.levels.WARN)
          end
        end,
      })
    end
  end,
})

-- Добавляем проверку здоровья null-ls
vim.api.nvim_create_user_command("NullLsHealth", function()
  local sources = require("null-ls.sources")
  local available = sources.get_available()
  
  print("=== Null-ls Health Check ===")
  for _, source in ipairs(available) do
    print(string.format("%-20s: %s", source.name, source.filetypes and table.concat(source.filetypes, ", ") or "all"))
  end
end, {})
