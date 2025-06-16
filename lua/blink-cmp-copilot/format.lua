local M = {}

---@param doc string
local trim_whitespace = function(doc)
  return string.gsub(doc, "^%s*(.-)%s*$", "%1")
end

---@param inputstr string
---@param sep? string
---@return string[]
local function split(inputstr, sep)
  sep = sep or inputstr:find("\r") and "\r" or "\n"
  if not string.find(inputstr, "[\r\n]") then
    return { inputstr }
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^\r\n]+)") do
    table.insert(t, str)
  end
  return t
end

M.format_item = function(item, ctx)
  local lines = split(item.text)
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0) -- {line, col}
  local row = cursor[1] - 1
  local col = cursor[2]

  local range = {
    start = { line = row, character = 0 },
    ["end"] = {
      line = row + #lines - 1,
      character = #lines[#lines],
    },
  }

  return {
    label = trim_whitespace(lines[1]),
    kind = vim.lsp.protocol.CompletionItemKind.Text,
    kind_name = "Copilot",
    kind_icon = "",
    textEdit = {
      newText = item.text,
      range = range,
    },
    insertTextFormat = vim.lsp.protocol.InsertTextFormat.PlainText,
    documentation = {
      kind = "markdown",
      value = string.format("```%s\n%s\n```", vim.bo.filetype, trim_whitespace(item.text)),
    },
  }
end

return M
