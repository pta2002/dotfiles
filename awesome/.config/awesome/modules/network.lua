-- We can use GObject Introspection to access NetworkManager's properties,
-- bypassing the need for something like nmcli
local gears   = require("gears")
local NM      = require("lgi").NM
local awful   = require("awful")
local client  = NM.Client.new()
local awesome = _G.awesome

local networking = { client = client }

-- This function refreshes information such as wifi availability, SSID,
-- connectivity, signal strength, etc.
function networking:refresh()
    local primary         = self.client:get_primary_connection()

    local info
    if primary then
        local connection_type = primary:get_connection_type()
        local is_wifi         = connection_type:find("wireless") ~= nil
        local is_eth          = connection_type:find("ethernet") ~= nil
        local name            = primary:get_id()

        info = {
            connection = primary,
            type       = connection_type,
            is_wifi    = is_wifi,
            is_eth     = is_eth,
            name       = name
        }

        if is_wifi then
            -- TODO find out how to get this! I'll need to get the device, but
            -- get_master() is returning nil for whatever reason, so...
            info.strength = 100
        end
    end

    awesome.emit_signal("network::update", info)

    -- awful.spawn("notify-send '" .. name .. "'")
end

-- Let's create some events for clients to subscribe to.
-- As far as I can tell, NM does not provide any "subscribe" functionality,
-- so we have to keep polling it, every 30s should be enough.
gears.timer {
    timeout   = 30,
    call_now  = true,
    autostart = true,
    callback  = function()
        networking:refresh()
    end
}

-- Honestly don't think much more is necessary, network manager handles
-- everything for us, it's kind of amazing
return networking
