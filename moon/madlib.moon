require "libs.require" --require help

--WORKING
	--persistance
	--room system
	--entities
	--key input
	--zording
--TODO
	--animation
	--sounds
	--camera
	--collision
	--map reader

--exports
export mad, ents, path, entAmt, debug --core stuff
export room, switch_room --room system
export drawSort --zord
export Entity --base ent class

--debug mode
debug = true

--rooms
room = ""
switch_room = false

--lib
entAmt = 0 --used for debugging purposes
ents = {}
mad = {
	--if the entity has a new function, run it, and then append it to the table
	addEnt: (e) =>
		if e.new ~= nil then e\new()
		table.insert(ents, e)
		entAmt += 1
		if debug then print("created ent ", e)

	--will put  a new class into the game
	createEnt: (c) =>
		e = c
		@addEnt(e)

	--surprisingly not broken function that removes ents
	removeEnt: (e) =>
		for k, v in pairs ents
			if v == e then
				table.remove(ents, k)
				if debug then print("removed ent", v)
				entAmt -= 1

	--update all ents
	update: (dt) =>
		for k, v in pairs ents
			if v.update ~= nil then v\update(dt)
	
	--zordin' and drawin'
	draw: =>
		if not switch_room then table.sort(ents, drawSort)
		for k, v in pairs ents
			if v.draw ~= nil then v\draw!

	--zord ents (called in base)
	zord: (s, mod) =>
		mod = mod or 0
		s.z = -s.y - (s.h) + mod

	--set room; delete non-persistent entities
	switchRoom: (r) =>
		room = r
		for k, v in pairs ents
			if not v.pers then @removeEnt(v)
		switch_room = true
		if debug then print("switched room to " .. r)

	--run room creation func
	runRoom: (r, func) =>
		if switch_room
			if room == r
				func!
				if debug then print("finished creating " .. r .. " objects for " .. room)
				switch_room = false
	
	--basic keys
	key: (k) =>
		if love.keyboard.isDown(k) then
			return true
		else
			return false

	--set col group for ent
	setCollisionGroup: (o, g) =>
		o.col = g

	--super wip
	collision: (s, c) =>
		for k, v in pairs ents
			if v.col == c then
				print("found thing to collide with")

	--misc maff
	clamp: (low, n, high) ->
		return math.min(math.max(low, n), high)
	lerp: (a,b,t) ->
		return (1-t)*a + t*b

	--kinda useless; polls object to see if it can access this lib			
	test: =>
		print("madlib is working for the polled object")
}

--reorganizes the table based off of the ents' z value
drawSort = (a, b) ->
	return a.z > b.z

--base entity class; has some base functionality
class Entity
	new: (@xpos, @ypos) =>
		@x = @xpos
		@y = @ypos
		@z = -@ypos
	update: (dt) =>
		mad\zord(self)