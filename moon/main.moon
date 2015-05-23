--stuff to require; madlib, data registry, entities
require "madlib"
require "reg"
require.tree "ents"

--room registry
room = {
	start: {
		name: "start"
		event: =>
			mad.object\createEnt(Example(200, 200))
			mad.object\createEnt(Example(200-32, 200))
			mad.object\createEnt(Example(200-32, 200-32))
			mad.object\createEnt(Box(300, 300))
	}
	--register other rooms here
}

love.load = ->
	mad.room\switchRoom("start")

love.update = (dt) ->
	--update all ents
	mad\update(dt)

	--run all room code
	for k, v in pairs room
		mad.room\runRoom(v.name, v.event)

love.draw = ->
	--draw all ents
	mad\draw!