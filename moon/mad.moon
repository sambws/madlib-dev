require "libs.require"

--exports
export mad, ents, room, switch_room

--rooms
room = ""
switch_room = false
debug = true

--lib
ents = {}
mad = {
	--if the entity has a new function, run it, and then append it to the table
	addEnt: (e) =>
		if e.new ~= nil then e\new()
		table.insert(ents, e)
		if debug then print("created ent")

	--surprisingly not broken
	removeEnt: (e) =>
		for k, v in pairs ents
			if v == e then
				table.remove(ents, k)
				if debug then print("removed ent")

	--update all ents
	update: (dt) =>
		for k, v in pairs ents
			if v.update ~= nil then v\update(dt)
		
	draw: =>
		--draw entities
		for k, v in pairs ents
			if v.draw ~= nil then v\draw!

	--set room
	switchRoom: (r) =>
		--set room
		room = r
		--delete non-pers ents
		for k, v in pairs ents
			if not v.pers then @removeEnt(v) 
		--create room
		if debug then print("switched room to " .. r)
		switch_room = true

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
	--dumb test			
	test: =>
		print("madlib is working for the requested object")
}