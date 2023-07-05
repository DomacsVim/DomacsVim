local M = {}

-- checking file (type)
function M.is_file(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file" or false
end

-- checking directory (type)
function M.is_directory(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory" or false
end

return M
