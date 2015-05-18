--the man of the hour
require("madlib")

--require random util stuff
require.tree("ents") --get all gameobjects
require("util")

--room creation
roomEvent = {
	start: =>
		mad\createEnt(Ship(200 - 16, 500))
		mad\createEnt(Alien(432, 300, -1))
		mad\createEnt(Alien(-32, 300, 1))
	lair: =>
}

--room registry
room = {
	start: {
		name: "start"
		event: roomEvent.start
	}
	lair: {
		name: "lair"
		event: roomEvent.lair
	}
}

love.load = ->
	--first room
	mad\switchRoom("start")

love.update = (dt) ->
	--update all ents
	mad\update(dt)

	--run all room code
	for k, v in pairs room
		mad\runRoom(v.name, v.event)

love.draw = ->
	--draw all ents
	mad\draw!

	--debuggin'
	if debug then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.print("FPS: " .. love.timer.getFPS(), 16, 16)
		love.graphics.print("amount of entities: " .. entAmt, 16, 32)