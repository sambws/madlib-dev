do
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self)
      if mad.input:joyConnected(1) then
        if mad.input:joyButton(self.joy, "a") then
          self.r = 0
        else
          self.r = 255
        end
        if mad.input:joyButton(self.joy, "b") then
          self.b = 0
        else
          self.b = 255
        end
        if mad.input:joyButton(self.joy, "x") then
          self.g = 0
        else
          self.g = 255
        end
        self.haxis = mad.input:joyAxis(self.joy, 1)
        self.vaxis = mad.input:joyAxis(self.joy, 2)
        if self.haxis <= -0.25 and mad:checkCol(self, self.x - 4, self.y, col.obj) < 1 then
          self.x = self.x + (self.haxis * self.spd)
        end
        if self.haxis >= 0.25 and mad:checkCol(self, self.x + 4, self.y, col.obj) < 1 then
          self.x = self.x + (self.haxis * self.spd)
        end
        if self.vaxis <= -0.25 and mad:checkCol(self, self.x, self.y - 4, col.obj) < 1 then
          self.y = self.y + (self.vaxis * self.spd)
        end
        if self.vaxis >= 0.25 and mad:checkCol(self, self.x, self.y + 4, col.obj) < 1 then
          self.y = self.y + (self.vaxis * self.spd)
        end
      end
      if mad.input:key("left") and mad:checkCol(self, self.x - 4, self.y, col.obj) < 1 then
        self.x = self.x - self.spd
      elseif mad.input:key("right") and not mad.input:key("left") and mad:checkCol(self, self.x + 4, self.y, col.obj) < 1 then
        self.x = self.x + self.spd
      end
      if mad.input:key("up") and not mad.input:key("down") and mad:checkCol(self, self.x, self.y - 4, col.obj) < 1 then
        self.y = self.y - self.spd
      elseif mad.input:key("down") and mad:checkCol(self, self.x, self.y + 4, col.obj) < 1 then
        self.y = self.y + self.spd
      end
      self.x = math.floor(self.x)
      self.y = math.floor(self.y)
      self.x = mad.math.clamp(0, self.x, 416 - self.w)
      self.y = mad.math.clamp(0, self.y, 608 - self.h)
      return _parent_0.update(self, self)
    end,
    draw = function(self)
      love.graphics.setColor(self.r, self.b, self.g, 255)
      return love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, xpos, ypos)
      self.xpos, self.ypos = xpos, ypos
      _parent_0.__init(self, self.xpos, self.ypos)
      self.w = 64
      self.h = 64
      self.spd = 4
      self.r = 0
      self.b = 0
      self.g = 0
      self.joy = joystick
      self.persistent = false
      return mad:setCollisionGroup(self, col.player)
    end,
    __base = _base_0,
    __name = "Box",
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
  Box = _class_0
  return _class_0
end
