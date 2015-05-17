require "libs.require"

--TODO
--zording it up

--exports
export mad, ents --core tables
export room, switch_room --room system
export drawSort --zord
export Entity

--debug mode
debug = true

--rooms
room = ""
switch_room = false

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
	
	--draw ents
	draw: =>
		--draw entities
		for k, v in pairs ents
			if v.draw ~= nil then v\draw!
	--zord ents
	zord: (s, mod) =>
		mod = mod or 0
		s.z = -s.y - (s.h) + mod

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
		print("madlib is working for the polled object")
}

--z-orders things
drawSort = (a, b) ->
	return a.z > b.z

--base entity class
class Entity
	new: (@xpos, @ypos) =>
		@x = @xpos
		@y = @ypos
		@z = -@ypos
	update: (dt) =>
		mad\zord(self)