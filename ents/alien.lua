do
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self, dt)
      if self.dir == 1 then
        self.x = self.x + self.horspd
      elseif self.dir == -1 then
        self.x = self.x - self.horspd
      end
      if self.ready then
        if self.x > 400 then
          self.dir = -self.dir
        end
        if self.x < 0 then
          self.dir = -self.dir
        end
      else
        if self.start == -1 then
          if self.x > 200 then
            self.ready = true
          end
        end
        if self.start == 1 then
          if self.x < 200 then
            self.ready = true
          end
        end
      end
      self.o_angle = self.o_angle + self.o_spd
      self.y = self.o_y + self.o_rad * math.cos(self.o_angle * math.pi / 180)
      return _parent_0.update(self, self)
    end,
    draw = function(self)
      love.graphics.setColor(255, 255, 255, 255)
      return love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, xpos, ypos, s)
      self.xpos, self.ypos, self.s = xpos, ypos, s
      _parent_0.__init(self, self.xpos, self.ypos)
      self.w = 32
      self.h = 32
      self.o_y = self.ypos
      self.pers = false
      self.start = self.s
      self.ready = false
      self.o_angle = 0
      self.o_rad = 25
      self.o_spd = 360 / 60
      self.dir = self.s
      self.horspd = 3
    end,
    __base = _base_0,
    __name = "Alien",
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
  Alien = _class_0
  return _class_0
end
