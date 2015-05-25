--stuff to require; madlib, data registry, entities
require "madlib"
require "reg"
require.tree "ents"

--room registry
room = {
	start: {
		name: "start"
		event: =>
			loadLevel("start")
	}
	lair: {
		name: "lair"
		event: =>
			loadLevel("lair")
	}
	--register other rooms here
}

love.load = ->
	--setup camera
	export cam = camera(0, 0, 1)
	mad.cam\look(cam, 0, 0)

	--switch the room
	mad.room\switchRoom("start")

love.update = (dt) ->
	--update all ents
	mad\update(dt)

	--run all room code
	for k, v in pairs room
		mad.room\runRoom(v.name, v.event)

love.draw = ->
	--draw all ents
	mad\draw(ents, cam)

love.timer.sleep = ->