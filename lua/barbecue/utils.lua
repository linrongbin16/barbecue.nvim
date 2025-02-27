local PATH_SEPARATOR = package.config:sub(1, 1)

local M = {}

---Escape string from statusline/winbar expansion.
---
---@param str string String to be escaped.
---@return string
function M.str_escape(str)
  str = str:gsub("%%", "%%%%")
  str = str:gsub("\n", " ")
  return str
end

---Calculate the length of UTF-8 string.
---
---@param str string UTF-8 string to calculate the length of.
---@return number
function M.str_len(str)
  local _, count = str:gsub("[^\128-\193]", "")
  return count
end

---Merge one or more list-like tables into one.
---
---@param list any[] Table to be merged into.
---@param ... any[] Tables to be merged.
function M.tbl_merge(list, ...)
  for _, l in ipairs({ ... }) do
    for _, value in ipairs(l) do
      table.insert(list, value)
    end
  end
end

---Check whether the current neovim version surpasses the given version.
---
---See: [Semantic Versioning](https://semver.org)
---
---@param major number
---@param minor number?
---@param patch number?
---@return boolean
function M.since_nvim(major, minor, patch)
  minor = minor or 0
  patch = patch or 0

  local v = vim.version()
  if v.major > major then return true end
  if v.major == major then
    if v.minor > minor then return true end
    if v.minor == minor then
      if v.patch >= patch then return true end
    end
  end

  return false
end

---Join any number of path elements into a single path, separating them with an
---OS specific separator.
---
---@param ... string
---@return string
function M.path_join(...) return table.concat({ ... }, PATH_SEPARATOR) end

return M
