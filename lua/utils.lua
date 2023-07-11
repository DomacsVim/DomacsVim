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

function M.replace_word(file, old, new)
  file = file or dvim_config_dir .. "/init.lua"
  local instance = io.open(file, "r")
  local added_pattern = string.gsub(old, "-", "%%-") -- add % before - if exists
  local new_content = instance:read("*all"):gsub(added_pattern, new)
  instance = io.open(file, "w")
  instance:write(new_content)
  instance:close()
end

return M
