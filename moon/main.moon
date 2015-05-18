--the man of the hour
require "mad"

--require all libs/entities
require.tree("ents")
require.tree("libs")

--room creation code
rooms = {
	start: =>
		mad\createEnt(Ship(32 ,32))
		mad\createEnt(Alien(400, 300, -1))
		mad\createEnt(Alien(0, 300, 1))
	lair: =>
}

--first level
love.load = ->
	mad\switchRoom("start")

--check for room creation/update ents
love.update = (dt) ->
	mad\update(dt)

	mad\runRoom("start", rooms.start)
	mad\runRoom("lair", rooms.lair)

--draw stuff
love.draw = ->
	if not switch_room then table.sort(ents, drawSort)
	mad\draw!

	--debugs
	if debug then
		love.graphics.print("FPS: " .. love.timer.getFPS(), 16, 16)
		love.graphics.print("amount of entities: " .. entAmt, 16, 32)