-- autopairs
-- https://github.com/windwp/nvim-autopairs
local handlers = require 'nvim-autopairs.completion.handlers'
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-autopairs').setup {}
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done {
        filetypes = {
          -- "*" is a alias to all filetypes
          ['*'] = {
            ['('] = {
              kind = {
                cmp.lsp.CompletionItemKind.Function,
                cmp.lsp.CompletionItemKind.Method,
              },
              handler = handlers['*'],
            },
          },
          lua = {
            ['('] = {
              kind = {
                cmp.lsp.CompletionItemKind.Function,
                cmp.lsp.CompletionItemKind.Method,
              },
              ---@param char string
              ---@param item table item completion
              ---@param bufnr number buffer number
              ---@param rules table
              ---@param commit_character table<string>
              handler = function(char, item, bufnr, rules, commit_character)
                -- Your handler function. Inspect with print(vim.inspect{char, item, bufnr, rules, commit_character})
              end,
            },
          },
          -- Disable for tex
          tex = false,
        },
      }
    )
  end,
}
