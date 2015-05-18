require("mad")
require.tree("ents")
require.tree("libs")
local rooms = {
  start = function(self)
    mad:createEnt(Ship(32, 32))
    mad:createEnt(Alien(400, 300, -1))
    return mad:createEnt(Alien(0, 300, 1))
  end,
  lair = function(self) end
}
love.load = function()
  return mad:switchRoom("start")
end
love.update = function(dt)
  mad:update(dt)
  mad:runRoom("start", rooms.start)
  return mad:runRoom("lair", rooms.lair)
end
love.draw = function()
  if not switch_room then
    table.sort(ents, drawSort)
  end
  mad:draw()
  if debug then
    love.graphics.print("FPS: " .. love.timer.getFPS(), 16, 16)
    return love.graphics.print("amount of entities: " .. entAmt, 16, 32)
  end
end
