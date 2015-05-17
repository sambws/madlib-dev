require("libs.require")
room = ""
switch_room = false
local debug = true
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
    return print("madlib is working for the requested object")
  end
}
drawSort = function(a, b)
  return a.z < b.z
end
