-- Parse iCal's file format
-- We are only parsing, not generating, which should be easier...
-- But the iCal file format is still an ugly mess!
--
-- https://tools.ietf.org/html/rfc5545
local l = require "lpeg"

-- Let's define some patterns
local p_iana_token = (l.R("az", "AZ", "09") + "-") ^ 1
local p_vendorid   = l.R("az", "AZ", "09") * l.R("az", "AZ", "09") * l.R("az", "AZ", "09")
local p_x_name     = l.P("X-") * (p_vendorid * l.P("-")) ^ -1 * p_iana_token
local p_name       = l.C(p_iana_token + p_x_name)

-- A basic UTF-8 grammar
-- https://tools.ietf.org/html/rfc3629#section-3
local p_utf8_tail = l.R("\x80\xbf")
local p_utf8_2    = l.R("\xc2\xdf") * p_utf8_tail
local p_utf8_3    = l.P("\xe0") * l.R("\xa0\xbf") * p_utf8_tail + l.R("\xe1\xec") * p_utf8_tail * p_utf8_tail +
  l.P("\xed") * l.R("\x80\x9f") * p_utf8_tail + l.R("\xee\xef") * p_utf8_tail * p_utf8_tail
local p_utf8_4    = l.P("\xf0") * l.R("\x90\xbf") * p_utf8_tail * p_utf8_tail +
  l.R("\xf1\xf3") * p_utf8_tail * p_utf8_tail * p_utf8_tail +
  l.P("\xf4") * l.R("\x80\x8f") * p_utf8_tail * p_utf8_tail

local p_NON_US_ASCII  = p_utf8_2 + p_utf8_3 + p_utf8_4
local p_SAFE_TEXT     = l.R("#+", "-9", "<~") + l.S("! \t") + p_NON_US_ASCII
local p_QSAFE_TEXT    = l.R("#~") + l.S("! \t") + p_NON_US_ASCII
local p_VALUE_CHAR    = l.S(" \t") + l.R("\x21\x7e") + p_NON_US_ASCII
local p_quoted_string = l.P('"') * p_QSAFE_TEXT ^ 0 * l.P('"')

-- Parameters
local p_param_name  = l.C(p_iana_token + p_x_name)
local p_param_value = l.C(p_SAFE_TEXT ^ 0 + p_quoted_string)
local p_value       = l.C(p_VALUE_CHAR ^ 0)

local p_param_values = l.Ct(p_param_value * (l.P(",") * p_param_value) ^ 0)
local p_param        = l.Cg(p_param_name * l.P("=") * p_param_values)
local p_params       = l.Cf(l.Ct("") * (p_param^0)^-1 * (l.P(";") * p_param) ^ 0, rawset)
local p_content_line = p_name * p_params * ":" * p_value

-- iCal text is wrapped
--
-- Here's an example:
-- a:very long text that is going to
--  wrap around at the edge
local function unwrap(text)
  local lines = {}
  local new_lines = {}

  for s in text:gmatch("[^\r\n]+") do
    table.insert(lines, s)
  end

  local j = 0
  for i=1,#lines do
    if lines[i]:sub(1,1) == " " then
      new_lines[j] = new_lines[j] .. lines[i]:sub(2,-1)
    else
      j = j + 1
      new_lines[j] = lines[i]
    end
  end

  return new_lines
end

local metatable = {
  __index = function(self, key)
    if rawget(self, key) then
      return rawget(self, key)
    end

    if rawget(self, "props") then
      for k, v in pairs(rawget(self, "props")) do
        if k:lower() == key then
          return v
        end
      end
    end

    if rawget(self, "children") then
      for _, v in ipairs(rawget(self, "children")) do
        if v.name:lower() == key then
          return v
        end
      end
    end

    return nil
  end
}

-- Example structure:
--
-- {
--   name = "VDOCUMENT",
--   children = {
--     {
--       name = "VEVENT",
--       children = {
--         {
--           name = "TIME",
--           props = { TZDATA = {"Europe/Lisbon"} },
--           value = "300000T1",
--         }
--       }
--     }
--   }
-- }
return function(text)
  text = unwrap(text)
  local current = nil
  for _, line in ipairs(text) do
    local name, props, val = p_content_line:match(line)

    if name == "BEGIN" then
      current = {
        name = val,
        parent = current,
        children = {}
      }

      setmetatable(current, metatable)
    elseif name == "END" then
      if current.parent then
        table.insert(current.parent.children, current)
        current = current.parent
      else
        return current
      end
    else
      local child = {
        name = name,
        props = props,
        value = val
      }
      setmetatable(child, metatable)
      table.insert(current.children, child)
    end
  end
end
