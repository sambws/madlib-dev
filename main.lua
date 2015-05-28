require("lib.madlib")
require("reg")
require.tree("ent")
room_reg = {
  start = {
    name = "start",
    event = function(self)
      loadLevel("test")
      mad.object:createEnt(Background(0, 0))
      return mad.object:createEnt(Thing(0, 0))
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
  mad:init()
  return mad.room:switchRoom("start")
end
love.update = function(dt)
  return mad:update(dt)
end
love.draw = function()
  mad:draw(ents, cam)
  return mad:draw(gui)
end
love.timer.sleep = function() end
