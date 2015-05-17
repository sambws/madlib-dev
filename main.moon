require "lib"
require "Square"
require "Test"

--room creation code
sq = Square(32, 32)
th = Test(64, 64)
rooms = {
	start: =>
		mad\addEnt(sq)
		mad\addEnt(th)
}

--first level
love.load = ->
	mad\switchRoom("start")

--check for room creation/update ents
love.update = (dt) ->
	mad\update(dt)
	mad\runRoom("start", rooms.start)

--draw stuff
love.draw = ->
	mad\draw!
	--love.graphics.print(32, 32, love.timer.getFPS())