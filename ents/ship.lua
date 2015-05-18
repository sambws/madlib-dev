do
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self, dt)
      self.x = self.x + self.xvel
      self.y = self.y + self.yvel
      self.xvel = self.xvel * (1 - math.min(dt * self.fric, 1))
      self.yvel = self.yvel * (1 - math.min(dt * self.fric, 1))
      if mad:key("left") and self.xvel < 100 then
        self.xvel = self.xvel - self.spd * dt
      end
      if mad:key("right") and self.xvel > -100 then
        self.xvel = self.xvel + self.spd * dt
      end
      if mad:key("up") and self.yvel < 100 then
        self.yvel = self.yvel - self.spd * dt
      end
      if mad:key("down") and self.yvel > -100 then
        self.yvel = self.yvel + self.spd * dt
      end
      self.x = mad.clamp(0, self.x, 400 - self.w)
      self.y = mad.clamp(0, self.y, 600 - self.h)
      if mad:key("z") then
        if not self.zpressed then
          mad:createEnt(Bullet(self.x + 8, self.y + (self.h / 2)))
          self.zpressed = true
        end
      else
        self.zpressed = false
      end
      if mad:key("rshift") then
        mad:switchRoom("coolio")
      end
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
    __init = function(self, xpos, ypos)
      self.xpos, self.ypos = xpos, ypos
      _parent_0.__init(self, self.xpos, self.ypos)
      self.w = 32
      self.h = 32
      self.pers = true
      mad:setCollisionGroup(self, col.player)
      self.xvel = 0
      self.yvel = 0
      self.fric = 10
      self.spd = 50
      self.zpressed = false
    end,
    __base = _base_0,
    __name = "Ship",
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
  Ship = _class_0
  return _class_0
end
