-- A wrapper to make "pill" widgets

local pill = { mt = {} }

function pill.new(left, left_bg, right, right_bg)
    
end

function pill.mt:__call(...)
    return self.new(...)
end

return pill
