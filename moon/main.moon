--the man of the hour
require("madlib")

--require stuff
require.tree("ents")
require("util")

--room creation
roomEvent = {
	start: =>
		--create entities here!
		mad\createEnt(Example(0 ,0))
}

--room registry
room = {
	--register rooms here!
	start: {
		name: "start"
		event: roomEvent.start
	}
}

love.load = ->
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