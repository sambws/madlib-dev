require("madlib")
require.tree("ents")
require("util")
local roomEvent = {
  start = function(self)
    return mad:createEnt(Example(0, 0))
  end
}
local room = {
  start = {
    name = "start",
    event = roomEvent.start
  }
}
love.load = function()
  return mad:switchRoom("start")
end
love.update = function(dt)
  mad:update(dt)
  for k, v in pairs(room) do
    mad:runRoom(v.name, v.event)
  end
end
love.draw = function()
  mad:draw()
  if debug then
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 16, 16)
    return love.graphics.print("amount of entities: " .. entAmt, 16, 32)
  end
end
