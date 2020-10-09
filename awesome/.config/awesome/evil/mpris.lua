---  A simple module to deal with MPRIS
---  It uses playerctl

local awful = require("awful")

local function make_format(fields)
  -- `fields` is a table of the fields we want to receive.
  local out = ""

  for _, v in ipairs(fields) do
    out = out .. v .. " {{" .. v .. "}}\n"
  end

  return out .. "---"
end

-- This has to return a function that takes in a single line
local function parse_format(out)
  return function(line)
    if line ~= "---" then
      local key, val = line:match("(%w+) (.*)")
      out[key] = val
    else
      awesome.emit_signal("evil::mpris", out)
    end
  end
end

local function make_playerctl_wrapper(cmd)
  return function()
    local cmd = "playerctl -i firefox " .. cmd

    awful.spawn.spawn(cmd)
  end
end

local format_string  = make_format({"title", "artist", "status"})
local monitor_script = "playerctl metadata -F -f \"" .. format_string .. "\" -i firefox"
local status = {}
local mpris = {
  play = make_playerctl_wrapper("play"),
  pause = make_playerctl_wrapper("pause"),
  play_pause = make_playerctl_wrapper("play-pause"),
  stop = make_playerctl_wrapper("stop"),
  go_next = make_playerctl_wrapper("next"),
  go_prev = make_playerctl_wrapper("previous"),
}

-- TODO more idiomatic wrappers for position, volume, loop, shuffle, status and
-- metadata

function mpris:emit_mpris_info()
  awful.spawn.with_line_callback(monitor_script, { stdout = parse_format(status) })
end

return mpris
