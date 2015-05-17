require("mad")
require.tree("ents")
require.tree("libs")
local rooms = {
  start = function(self)
    local sq = Square(32, 32)
    return mad:addEnt(sq)
  end
}
love.load = function()
  return mad:switchRoom("start")
end
love.update = function(dt)
  mad:update(dt)
  return mad:runRoom("start", rooms.start)
end
love.draw = function()
  return mad:draw()
end
