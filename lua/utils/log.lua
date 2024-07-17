local log = {}

local utils = require "utils.modules"

log.levels = {
  INFO = "INFO",
  TRACE = "TRACE",
  WARN = "WARN",
  ERROR = "ERROR",
}

function log:log_format(text, level)
  text = text or ""
  level = level or log.levels.INFO
  local time = os.date "*t"
  local get_time = string.format("%s:%s:%s", time.hour, time.min, time.sec)
  local log_format = string.format("%s [%s] DomacsVim: %s", get_time, level, text)
  return log_format
end

function log:init(message)
  local file_path = utils.join_paths(dvim_cache_dir, "dvim.log")
  local file = io.open(file_path, "a")
  if file ~= nil then
    io.output(file)
    io.write(message .. "\n")
    io.close(file)
  end
end

function log:INFO(text)
  log:init(log:log_format(text, log.levels.INFO))
end

function log:TRACE(text)
  log:init(log:log_format(text, log.levels.TRACE))
end

function log:WARN(text)
  log:init(log:log_format(text, log.levels.WARN))
end

function log:ERROR(text)
  log:init(log:log_format(text, log.levels.ERROR))
end

return log
