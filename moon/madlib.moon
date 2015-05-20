require "libs.require" --require help
anim8 = require "libs.anim8" --animation

--WORKING
	--persistance
	--room system
	--entities
	--key input
	--game controller input
	--zording
--TODO
	--animation
	--sounds
	--camera
	--collision
	--map reader

--controllas
export joysticks = love.joystick.getJoysticks()

--debug mode
export debug = true

--rooms
export room = ""
export switch_room = false

--lib
export entAmt = 0 --used for debugging purposes
export ents = {}
export mad = {
	--if the entity has a new function, run it, and then append it to the table
	addEnt: (e) =>
		if e.new ~= nil then e\new()
		table.insert(ents, e)
		entAmt += 1
		if debug then print("created ent ", e)

	--will put  a new class into the game
	createEnt: (e) =>
		a = e
		@addEnt(a)

	--surprisingly not broken function that removes ents
	removeEnt: (e) =>
		for k, v in pairs ents
			if v == e then
				if v.destroy ~= nil then e\destroy()
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

	--returns image
	img: (p) =>
		return love.graphics.newImage(p)

	--sets up an image with a grid for animation
	gImg: (p, fw, fh) =>
		i = love.graphics.newImage(p)
		g = anim8.newGrid(fw, fh, i\getWidth(), i\getHeight())
		return i, g

	--sets up a grid for an image
	grid: (img, tw, th) =>
		return anim8.newGrid(tw, th, img\getWidth(), img\getHeight())

	--defines an animation (grid, frames, row, interval)
	anim: (g, f, r, spd) =>
		return anim8.newAnimation(g(f, r), spd)

	--gamepad stuff
	getControllers: =>
		a = love.joystick.getJoysticks()
		return a

	--get gamepad button down
	joyButton: (c, b) =>
		if c\isGamepadDown(b) then
			return true
		else
			return false

	--get axis of gamepad
	joyAxis: (c, a) =>
		return c\getAxis(a)

	--check if there's a certain controller connected
	joyConnected: (c) =>
		if joysticks[c] ~= nil
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
export drawSort = (a, b) ->
	return a.z > b.z

--base entity class; has some base functionality
export class Entity
	new: (@xpos, @ypos) =>
		@x = @xpos
		@y = @ypos
		@z = -@ypos
	update: (dt) =>
		mad\zord(self)