--the man of the hour
require "mad"

--require all libs/entities
require.tree("ents")
require.tree("libs")

--room creation code
rooms = {
	start: =>
		mad\createEnt(Ship(200 - 16, 500))
		mad\createEnt(Alien(432, 300, -1))
		mad\createEnt(Alien(-32, 300, 1))
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
	mad\draw!

	--debugs
	if debug then
		love.graphics.print("FPS: " .. love.timer.getFPS(), 16, 16)
		love.graphics.print("amount of entities: " .. entAmt, 16, 32)