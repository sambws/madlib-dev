require("madlib")
require("reg")
require.tree("ents")
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
  }
}
love.load = function()
  cam = camera(0, 0, 1)
  mad.cam:look(cam, 0, 0)
  return mad.room:switchRoom("lair")
end
love.update = function(dt)
  mad:update(dt)
  for k, v in pairs(room) do
    mad.room:runRoom(v.name, v.event)
  end
end
love.draw = function()
  return mad:draw(ents, cam)
end
love.timer.sleep = function() end
