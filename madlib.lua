require("libs.require")
joysticks = love.joystick.getJoysticks()
debug = true
room = ""
switch_room = false
entAmt = 0
ents = { }
mad = {
  addEnt = function(self, e)
    if e.new ~= nil then
      e:new()
    end
    table.insert(ents, e)
    entAmt = entAmt + 1
    if debug then
      return print("created ent ", e)
    end
  end,
  createEnt = function(self, c)
    local e = c
    return self:addEnt(e)
  end,
  removeEnt = function(self, e)
    for k, v in pairs(ents) do
      if v == e then
        table.remove(ents, k)
        if debug then
          print("removed ent", v)
        end
        entAmt = entAmt - 1
      end
    end
  end,
  update = function(self, dt)
    for k, v in pairs(ents) do
      if v.update ~= nil then
        v:update(dt)
      end
    end
  end,
  draw = function(self)
    if not switch_room then
      table.sort(ents, drawSort)
    end
    for k, v in pairs(ents) do
      if v.draw ~= nil then
        v:draw()
      end
    end
  end,
  zord = function(self, s, mod)
    mod = mod or 0
    s.z = -s.y - (s.h) + mod
  end,
  switchRoom = function(self, r)
    room = r
    for k, v in pairs(ents) do
      if not v.pers then
        self:removeEnt(v)
      end
    end
    switch_room = true
    if debug then
      return print("switched room to " .. r)
    end
  end,
  runRoom = function(self, r, func)
    if switch_room then
      if room == r then
        func()
        if debug then
          print("finished creating " .. r .. " objects for " .. room)
        end
        switch_room = false
      end
    end
  end,
  key = function(self, k)
    if love.keyboard.isDown(k) then
      return true
    else
      return false
    end
  end,
  getControllers = function(self)
    local a = love.joystick.getJoysticks()
    return a
  end,
  joyButton = function(self, c, b)
    if c:isGamepadDown(b) then
      return true
    else
      return false
    end
  end,
  joyAxis = function(self, c, a)
    return c:getAxis(a)
  end,
  joyConnected = function(self, c)
    if joysticks[c] ~= nil then
      return true
    else
      return false
    end
  end,
  setCollisionGroup = function(self, o, g)
    o.col = g
  end,
  collision = function(self, s, c)
    for k, v in pairs(ents) do
      if v.col == c then
        print("found thing to collide with")
      end
    end
  end,
  clamp = function(low, n, high)
    return math.min(math.max(low, n), high)
  end,
  lerp = function(a, b, t)
    return (1 - t) * a + t * b
  end,
  test = function(self)
    return print("madlib is working for the polled object")
  end
}
drawSort = function(a, b)
  return a.z > b.z
end
do
  local _base_0 = {
    update = function(self, dt)
      return mad:zord(self)
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, xpos, ypos)
      self.xpos, self.ypos = xpos, ypos
      self.x = self.xpos
      self.y = self.ypos
      self.z = -self.ypos
    end,
    __base = _base_0,
    __name = "Entity"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Entity = _class_0
end
