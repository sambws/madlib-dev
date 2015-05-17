do
  local _base_0 = {
    update = function(self, dt)
      if mad:key("left") then
        self.x = self.x - self.spd
      elseif mad:key("right") then
        self.x = self.x + self.spd
      end
      if mad:key("up") then
        self.y = self.y - self.spd
      elseif mad:key("down") then
        self.y = self.y + self.spd
      end
    end,
    draw = function(self)
      love.graphics.setColor(255, 255, 0, 255)
      return love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, xpos, ypos)
      self.xpos, self.ypos = xpos, ypos
      self.x = self.xpos
      self.y = self.ypos
      self.w = 32
      self.h = 32
      self.z = -self.ypos
      self.spd = 2
    end,
    __base = _base_0,
    __name = "Square"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Square = _class_0
  return _class_0
end
