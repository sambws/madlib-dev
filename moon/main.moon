--the man of the hour
require "mad"

--require all libs/entities
require.tree("ents")
require.tree("libs")

--room creation code
rooms = {
	start: =>
		sq = Square(32, 32)
		bb = BigBox(64, 64)
		mad\addEnt(sq)
		mad\addEnt(bb)
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
	table.sort(ents, drawSort)
	mad\draw!
	love.graphics.print(love.timer.getFPS(), 32, 32)