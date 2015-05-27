require("lib.madlib")
require("reg")
require.tree("ent")
local room = {
  start = {
    name = "start",
    event = function(self)
      loadLevel("test")
      return mad.object:createEnt(Background(0, 0))
    end
  },
  donkey = {
    name = "donkey",
    event = function(self)
      return loadLevel("othertest")
    end
  }
}
love.load = function()
  cam = camera(0, 0, 1)
  mad.cam:look(cam, 0, 0)
  return mad.room:switchRoom("start")
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
