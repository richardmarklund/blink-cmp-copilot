local M = {}

---@return blink.cmp.CompletionItem
M.format_item = function(item, ctx, opts)
  return {
    label = item.text,
    kind = vim.lsp.protocol.CompletionItemKind.Text,
    textEdit = {
      newText = item.text,
      range = item.range,
    },
  }
end

return M
