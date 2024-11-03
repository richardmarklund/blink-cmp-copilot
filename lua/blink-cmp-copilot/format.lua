local M = {}

---@param doc string
local trim_whitespace = function(doc)
  return string.gsub(doc, "^%s*(.-)%s*$", "%1")
end

---@return blink.cmp.CompletionItem
M.format_item = function(item, ctx, opts)
  return {
    label = trim_whitespace(item.text),
    kind = vim.lsp.protocol.CompletionItemKind.Text,
    textEdit = {
      newText = item.text,
      range = item.range,
    },
    documentation = {
      kind = "markdown",
      value = string.format("```%s\n%s\n```\n", vim.bo.filetype, trim_whitespace(item.text)),
    },
  }
end

return M
