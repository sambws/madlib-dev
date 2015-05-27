--madlib
--requires everything in the lib folder, is required by main.moon

require "lib.require"
require "lib.TEsound" --sound
anim8 = require "lib.anim8" --animation
export camera = require "lib.camera" --camera

--WORKING
	--room system/persistence
	--entities
	--key input
	--game controller input
	--zording
	--basic collision functions
	--camera
	--really basic entity mapper
--TODO
	--organize
	--work on the entity mapper
	--optimize functions so they don't all use fat arrows (i'm a dumbass)
	--STI STI STI STI!!!!!!!
	--make a branch that uses gamera instead of hump.camera to see if it's more intuitive (would have to heavily rework draw())
	--spend 400 hours organizing this mess
	--in-game debug console???

--controllas
export joysticks = love.joystick.getJoysticks()

--debug mode
export debug = true

--rooms
export room = ""
export switch_room = false

--lib
export entAmt = 0
export ents = {}
export gui = {}
export mad = {

	--startup
	init: =>
		--setup camera
		export cam = camera(0, 0, 1)
		mad.cam\look(cam, 0, 0)

	--will update both gui and ent tables
	update: (dt) =>
		--ent code
		for k, v in pairs ents
			if v.update ~= nil then v\update(dt)
		--gui code
		for k, v in pairs gui
			if v.update ~= nil then v\update(dt)
		--run all room code
		for k, v in pairs room_reg
			mad.room\runRoom(v.name, v.event)

	--drawing. takes a table to draw and an optional camera to draw them to
	draw: (tab, cam) =>
		--is there a camera?
		cam = cam or nil
		--zorder them up
		if tab == ents then
			if not switch_room then
				table.sort(tab, @drawSort)
		--draw em
		for k, v in pairs tab
			if v.draw ~= nil then 
				if cam then
					cam\attach()
					v\draw!
					cam\detach()
				else
					v\draw!
		--debuggin'
		if debug then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.print("FPS: " .. love.timer.getFPS(), 16, 16)
			love.graphics.print("amount of entities: " .. entAmt, 16, 32)

	--reorganizes the table based off of the ents' z value
	drawSort: (a, b) ->
		return a.z > b.z

	--some random camera functions i guess
	cam:
		look: (cam, x, y) =>
			ox, oy = cam\cameraCoords(x, y)
			cam\lookAt(ox, oy)

	--entities
	object:
		--run entity's new function and then add it to the ent table
		addEnt: (e) =>
			table.insert(ents, e)
			if e.new ~= nil then e\new()
			entAmt += 1

			if debug then print("created ent ", e)

		--will put a new class into the game
		createEnt: (e) =>
			@addEnt(e)

		--inserts an object into the gui table
		createGUI: (e) =>
			a = e
			if e.new ~= nil then e\new()
			table.insert(gui, e)
			if debug then print("created gui ", e)

		--weird and probably doensn't work
		removeEnt: (e) =>
			for k, v in pairs ents
				if v == e then
					--run actions
					if v.destroy ~= nil then e\destroy()
					entAmt -= 1

					--make the entity nil
					ents[k] = nil

					--debug
					if debug then print("removed ent", v)

	--drawing and animating
	sprite:
		--returns a basic image from a path
		img: (p) =>
			return love.graphics.newImage(path.img .. p)

		--sets up an image with a grid for animation
		gImg: (p, fw, fh) =>
			i = love.graphics.newImage(path.img .. p)
			g = anim8.newGrid(fw, fh, i\getWidth(), i\getHeight())
			return i, g

		--sets up a grid for an image
		grid: (img, tw, th) =>
			return anim8.newGrid(tw, th, img\getWidth(), img\getHeight())

		--defines an animation (grid, frames, row, interval)
		anim: (g, f, r, spd) =>
			return anim8.newAnimation(g(f, r), spd)

		--zord ents (called in base)
		zord: (s, mod) =>
			mod = mod or 0
			s.z = -s.y - (s.h) + mod

	--what the player will input to the game
	input:
		--basic keyboard keys
		key: (k) =>
			if love.keyboard.isDown(k) then
				return true
			else
				return false

		--get controller list
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

	--rooms
	room:
		--set room
		switchRoom: (r) =>
			--delete everything non-persistent
			for k, v in pairs (ents)
    			if v.persistent == false
    				mad.object\removeEnt(v)
    			else
    				if debug then print(v, "is persistent")
    		--set room; run code
			room = r
			switch_room = true
			if debug then print("switched room to " .. r)

		--run room creation func
		runRoom: (r, func) =>
			if switch_room
				if room == r
					func!
					if debug then print("finished creating objects for " .. room)
					switch_room = false

	--sound functionality
	audio:
		--plays a sound
		playSound: (sound, tags, v, p) =>
			v = v or 1
			p = p or 1
			TEsound.play(path.snd .. sound, tags, v, p)

		--loop sound
		loopSound: (sound, tags, n, v, p) =>
			v = v or 1
			p = p or 1
			n = n or nil
			TEsound.playLooping(path.snd .. sound, tags, n, v, p)

	--math stuff
	math:
		clamp: (low, n, high) ->
			return math.min(math.max(low, n), high)
			
		lerp: (a,b,t) ->
			return (1-t)*a + t*b

		distance: ( x1, y1, x2, y2 ) ->
			dx = x1 - x2
			dy = y1 - y2
			return math.sqrt ( dx * dx + dy * dy )

	col:
		--will return how many objects of a given tag are within an object's boundingbox
		colList: (s, x, y, colg) =>
			list = {}
			for k, v in pairs ents
				if v.col == colg and v ~= s then
					if @boundingBox(x, y, s, v) then
						table.insert(list, v)
			return list

		--check if object is overlapping other object
		boundingBox: (x, y, o, o2) =>
			return x < o2.x+o2.w and o2.x < x+o.w and y < o2.y+o2.h and o2.y < y+o.h


	--set col group for ent
	setCollisionGroup: (o, g) =>
		o.col = g

	--will automatically return the size of a colList
	checkCol: (s, x, y, colg) =>
		return #self.col\colList(s, x, y, colg)

	--kinda useless; polls object to see if it can access this lib			
	test: =>
		print("madlib is working for the polled object")

}

--base entity class; has some base functionality
export class Entity
	new: (@xpos, @ypos) =>
		@x = @xpos
		@y = @ypos
		@z = -@ypos
		@persistent = false
	update: (dt) =>
		mad.sprite\zord(self)