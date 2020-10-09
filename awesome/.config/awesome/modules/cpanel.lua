-- A nice and fancy control panel!
local cpanel = {
   open = false
}

function cpanel:toggle()
   self.open = not self.open
end

return cpanel
