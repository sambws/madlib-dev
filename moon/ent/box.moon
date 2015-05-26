export Box

class Box extends Entity
	new: (@xpos, @ypos) =>
		--setup
		super @xpos, @ypos
		@w = 64
		@h = 64
	
		--vars
		@spd = 4

		--button vars (rbg values)
		@r = 0
		@b = 0
		@g = 0

		--joy var
		@joy = joystick

		--set group for collision
		mad\setCollisionGroup(self, col.player)

	update: =>
		--if there's a joystick connected...
		if mad.input\joyConnected(1) then
			--do some button stuff
			if mad.input\joyButton(@joy, "a") then
				@r = 0
			else
				@r = 255
			if mad.input\joyButton(@joy, "b") then
				@b = 0
			else
				@b = 255
			if mad.input\joyButton(@joy, "x") then
				@g = 0
			else
				@g = 255

			--constantly assign the movement axis
			@haxis = mad.input\joyAxis(@joy, 1)
			@vaxis = mad.input\joyAxis(@joy, 2)

			--check for collisions and deadzones
			if @haxis <= -0.25 and mad\checkCol(@, @x-4, @y, col.obj) < 1
				@x += @haxis * @spd
			if @haxis >= 0.25 and mad\checkCol(@, @x+4, @y, col.obj) < 1 then
				@x += @haxis * @spd
			if @vaxis <= -0.25 and mad\checkCol(@, @x, @y-4, col.obj) < 1
				@y += @vaxis * @spd
			if @vaxis >= 0.25 and mad\checkCol(@, @x, @y+4, col.obj) < 1
				@y += @vaxis * @spd

		--keyboart
		if mad.input\key("left") and mad\checkCol(@, @x-4, @y, col.obj) < 1 then
			@x -= @spd
		elseif mad.input\key("right") and not mad.input\key("left") and mad\checkCol(@, @x+4, @y, col.obj) < 1 then
			@x += @spd
		if mad.input\key("up") and not mad.input\key("down") and mad\checkCol(@, @x, @y-4, col.obj) < 1 then
			@y -= @spd
		elseif mad.input\key("down") and mad\checkCol(@, @x, @y+4, col.obj) < 1 then
			@y += @spd

		--make the x/y values whole numbers
		@x = math.floor(@x)
		@y = math.floor(@y)

		--safety
		@x = mad.math.clamp(0, @x, 400 - @w)
		@y = mad.math.clamp(0, @y, 600 - @h)

		super self

	draw: =>
		love.graphics.setColor(@r, @b, @g, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)