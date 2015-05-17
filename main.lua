require("lib")
require("Square")
require("Test")
local sq = Square(32, 32)
local th = Test(64, 64)
local rooms = {
  start = function(self)
    mad:addEnt(sq)
    return mad:addEnt(th)
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
