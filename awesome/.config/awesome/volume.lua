-- Little volume widget for pulseaudio
-- Requires pamixer

local volume = { }

local function pamixer(args)
    local command = "pamixer " .. table.concat(args, " ")
    local f = io.popen(command)
    local text = f:read("*line")
    f:close()

    return text
end

function volume.raise()
    pamixer({"-i", "5"})
end

function volume.lower()
    pamixer({"-d", "5"})
end

function volume.getvolume()
    return tonumber(pamixer({"--get-volume"}))
end

return volume
