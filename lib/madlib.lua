require("lib.require")
require("lib.TEsound")
local anim8 = require("lib.anim8")
camera = require("lib.camera")
joysticks = love.joystick.getJoysticks()
debug = false
room = ""
switch_room = false
entAmt = 0
ents = { }
gui = { }
mad = {
  update = function(self, dt)
    for k, v in pairs(ents) do
      if v.update ~= nil then
        v:update(dt)
      end
    end
    for k, v in pairs(gui) do
      if v.update ~= nil then
        v:update(dt)
      end
    end
  end,
  draw = function(self, tab, cam)
    cam = cam or nil
    if tab == ents then
      if not switch_room then
        table.sort(tab, self.drawSort)
      end
    end
    for k, v in pairs(tab) do
      if v.draw ~= nil then
        if cam then
          cam:attach()
          v:draw()
          cam:detach()
        else
          v:draw()
        end
      end
    end
    if debug then
      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.print("FPS: " .. love.timer.getFPS(), 16, 16)
      return love.graphics.print("amount of entities: " .. entAmt, 16, 32)
    end
  end,
  drawSort = function(a, b)
    return a.z > b.z
  end,
  cam = {
    look = function(self, cam, x, y)
      local ox, oy = cam:cameraCoords(x, y)
      return cam:lookAt(ox, oy)
    end
  },
  object = {
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
    createEnt = function(self, e)
      local a = e
      return self:addEnt(a)
    end,
    createGUI = function(self, e)
      local a = e
      if e.new ~= nil then
        e:new()
      end
      table.insert(gui, e)
      if debug then
        return print("created gui ", e)
      end
    end,
    removeEnt = function(self, e)
      for k, v in pairs(ents) do
        if v == e then
          if v.destroy ~= nil then
            e:destroy()
          end
          table.remove(ents, k)
          if debug then
            print("removed ent", v)
          end
          entAmt = entAmt - 1
        end
      end
    end,
    setMask = function(self, e) end
  },
  sprite = {
    img = function(self, p)
      return love.graphics.newImage(path.img .. p)
    end,
    gImg = function(self, p, fw, fh)
      local i = love.graphics.newImage(path.img .. p)
      local g = anim8.newGrid(fw, fh, i:getWidth(), i:getHeight())
      return i, g
    end,
    grid = function(self, img, tw, th)
      return anim8.newGrid(tw, th, img:getWidth(), img:getHeight())
    end,
    anim = function(self, g, f, r, spd)
      return anim8.newAnimation(g(f, r), spd)
    end,
    zord = function(self, s, mod)
      mod = mod or 0
      s.z = -s.y - (s.h) + mod
    end
  },
  input = {
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
    end
  },
  room = {
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
            print("finished creating objects for " .. room)
          end
          switch_room = false
        end
      end
    end
  },
  audio = {
    playSound = function(self, sound, tags, v, p)
      v = v or 1
      p = p or 1
      return TEsound.play(path.snd .. sound, tags, v, p)
    end,
    loopSound = function(self, sound, tags, n, v, p)
      v = v or 1
      p = p or 1
      n = n or nil
      return TEsound.playLooping(path.snd .. sound, tags, n, v, p)
    end
  },
  math = {
    clamp = function(low, n, high)
      return math.min(math.max(low, n), high)
    end,
    lerp = function(a, b, t)
      return (1 - t) * a + t * b
    end,
    distance = function(x1, y1, x2, y2)
      local dx = x1 - x2
      local dy = y1 - y2
      return math.sqrt((dx * dx + dy * dy))
    end
  },
  col = {
    colList = function(self, s, x, y, colg)
      local list = { }
      for k, v in pairs(ents) do
        if v.col == colg and v ~= s then
          if self:boundingBox(x, y, s, v) then
            table.insert(list, v)
          end
        end
      end
      return list
    end,
    boundingBox = function(self, x, y, o, o2)
      return x < o2.x + o2.w and o2.x < x + o.w and y < o2.y + o2.h and o2.y < y + o.h
    end
  },
  setCollisionGroup = function(self, o, g)
    o.col = g
  end,
  checkCol = function(self, s, x, y, colg)
    return self.tableSize(self.col:colList(s, x, y, colg))
  end,
  tableSize = function(tab)
    local c = 0
    for k, v in pairs((tab)) do
      c = c + 1
    end
    return c
  end,
  test = function(self)
    return print("madlib is working for the polled object")
  end
}
do
  local _base_0 = {
    update = function(self, dt)
      return mad.sprite:zord(self)
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
