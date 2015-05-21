--stuff to require; madlib, data registry, entities
require "madlib"
require "reg"
require.tree "ents"

--room registry
room = {
	start: {
		name: "start"
		event: =>
			mad.object\createEnt(Box(0, 0))
			mad.object\createEnt(Example(0, 0))
	}
	--register other rooms here
}

love.load = ->
	mad.room\switchRoom("start")
	mad.audio\playSound("DUHDUHDUH.mp3", "music")

love.update = (dt) ->
	--update all ents
	mad\update(dt)

	--run all room code
	for k, v in pairs room
		mad.room\runRoom(v.name, v.event)

love.draw = ->
	--draw all ents
	mad\draw!

	--debuggin'
	if debug then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.print("FPS: " .. love.timer.getFPS(), 16, 16)
		love.graphics.print("amount of entities: " .. entAmt, 16, 32)