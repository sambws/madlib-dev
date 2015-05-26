require("lib.madlib")
require("reg")
require.tree("ent")
local room = {
  start = {
    name = "start",
    event = function(self)
      return loadLevel("start")
    end
  },
  lair = {
    name = "lair",
    event = function(self)
      return loadLevel("lair")
    end
  },
  ok = {
    name = "ok",
    event = function(self)
      loadLevel("nice")
      return mad.object:createGUI(Score(0, 0))
    end
  }
}
love.load = function()
  mad.setWindow({
    w = 1920,
    h = 1080,
    full = false,
    vsync = false,
    aa = 0
  }, 416, false, false)
  cam = camera(0, 0, 1)
  mad.cam:look(cam, 0, 0)
  return mad.room:switchRoom("ok")
end
love.update = function(dt)
  mad:update(dt)
  for k, v in pairs(room) do
    mad.room:runRoom(v.name, v.event)
  end
end
love.draw = function()
  mad:draw(ents, cam)
  return mad:draw(gui)
end
love.timer.sleep = function() end
