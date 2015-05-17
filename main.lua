require("mad")
require.tree("ents")
require.tree("libs")
local rooms = {
  start = function(self)
    local sq = Square(32, 32)
    local bb = BigBox(64, 64)
    mad:addEnt(sq)
    return mad:addEnt(bb)
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
  table.sort(ents, drawSort)
  mad:draw()
  return love.graphics.print(love.timer.getFPS(), 32, 32)
end
