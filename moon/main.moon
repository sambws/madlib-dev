--the man of the hour
require "mad"

--require all libs/entities
require.tree("ents")
require.tree("libs")

--room creation code
rooms = {
	start: =>
		sq = Square(32, 32)
		mad\addEnt(sq)
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