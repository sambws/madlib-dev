do
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self, dt)
      self.dx, self.dy = 0, 0
      if mad.input:key("right") then
        self.dx = self.spd * dt
      elseif mad.input:key("left") then
        self.dx = -self.spd * dt
      end
      if mad.input:key("up") then
        self.dy = -self.spd * dt
      elseif mad.input:key("down") then
        self.dy = self.spd * dt
      end
      if self.dx ~= 0 or self.dy ~= 0 then
        self.x, self.y = world:move(self, self.x + self.dx, self.y + self.dy)
      end
    end,
    draw = function(self)
      love.graphics.setColor(255, 255, 255, 255)
      return love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, xpos, ypos)
      self.xpos, self.ypos = xpos, ypos
      _parent_0.__init(self, self.xpos, self.ypos)
      self.w = 32
      self.h = 32
      self.spd = 80
      return world:add(self, self.x, self.y, self.w, self.h)
    end,
    __base = _base_0,
    __name = "Player",
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
  Player = _class_0
  return _class_0
end
