do
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self, dt)
      if mad.input:key("z") then
        if not self.pressed then
          mad.room:switchRoom("donkey")
          self.pressed = true
        end
      end
    end,
    draw = function(self) end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, xpos, ypos)
      self.xpos, self.ypos = xpos, ypos
      _parent_0.__init(self, self.xpos, self.ypos)
      self.w = love.graphics.getWidth()
      self.h = love.graphics.getHeight()
      self.pressed = false
      self.persistent = true
    end,
    __base = _base_0,
    __name = "Background",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Background = _class_0
  return _class_0
end
