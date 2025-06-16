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
  if sep == nil then
    sep = "\n"
  end
  if not string.find(inputstr, "[\r|\n]") then
    return { inputstr }
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

---@return blink.cmp.CompletionItem
M.format_item = function(item, ctx)
  local lines = split(item.text)
  local range = vim.deepcopy(item.range)

  -- Fallback: if item.range is empty or malformed, use cursor
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  range.start = {
    line = row - 1,
    character = col,
  }
  range["end"].line = range.start.line + #lines - 1
  range["end"].character = #lines[#lines]

  return {
    label = trim_whitespace(lines[1]),
    kind = vim.lsp.protocol.CompletionItemKind.Text,
    kind_name = "Copilot",
    kind_icon = "",
    textEdit = {
      newText = item.text,
      range = range,
    },
    documentation = {
      kind = "markdown",
      value = string.format("```%s\n%s\n```", vim.bo.filetype, trim_whitespace(item.text)),
    },
  }
end


return M
