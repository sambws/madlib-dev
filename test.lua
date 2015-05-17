do
  local _base_0 = {
    update = function(self, dt) end,
    draw = function(self)
      love.graphics.setColor(255, 0, 0, 255)
      return love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, xpos, ypos)
      self.xpos, self.ypos = xpos, ypos
      self.x = self.xpos
      self.y = self.ypos
      self.w = 64
      self.h = 64
      self.z = -self.ypos
    end,
    __base = _base_0,
    __name = "Test"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Test = _class_0
  return _class_0
end
