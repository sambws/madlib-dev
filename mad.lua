require("libs.require")
local debug = true
room = ""
switch_room = false
ents = { }
mad = {
  addEnt = function(self, e)
    if e.new ~= nil then
      e:new()
    end
    table.insert(ents, e)
    if debug then
      return print("created ent")
    end
  end,
  removeEnt = function(self, e)
    for k, v in pairs(ents) do
      if v == e then
        table.remove(ents, k)
        if debug then
          print("removed ent")
        end
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
    if debug then
      print("switched room to " .. r)
    end
    switch_room = true
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
  return _class_0
end
