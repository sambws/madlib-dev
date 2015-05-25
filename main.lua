require("madlib")
require("reg")
require.tree("ents")
local room = {
  start = {
    name = "start",
    event = function(self)
      mad.object:createEnt(Example(200, 200))
      mad.object:createEnt(Example(200 - 32, 200))
      mad.object:createEnt(Example(200 - 32, 200 - 32))
      return mad.object:createEnt(Box(300, 300))
    end
  }
}
love.load = function()
  return mad.room:switchRoom("start")
end
love.update = function(dt)
  mad:update(dt)
  for k, v in pairs(room) do
    mad.room:runRoom(v.name, v.event)
  end
end
love.draw = function()
  return mad:draw()
end
love.timer.sleep = function() end
