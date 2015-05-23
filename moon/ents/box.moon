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

			if mad\checkCol(@, @x-10, @y, col.obj) < 1 then
				if @haxis <= -0.25
						@x += @haxis * @spd + 1
			if mad\checkCol(@, @x+10, @y, col.obj) < 1 then
				if @haxis >= 0.25
					@x += @haxis * @spd + 1

			if mad\checkCol(@, @x, @y-10, col.obj) < 1 then
				if @vaxis <= -0.25
					@y += @vaxis * @spd + 1
			if mad\checkCol(@, @x, @y+10, col.obj) < 1 then
				if @vaxis >= 0.25
					@y += @vaxis * @spd + 1

		if mad.input\key("left") and mad\checkCol(@, @x-10, @y, col.obj) < 1 then
			@x -= @spd
		elseif mad.input\key("right") and mad\checkCol(@, @x+10, @y, col.obj) < 1 then
			@x += @spd
		if mad.input\key("up") and mad\checkCol(@, @x, @y-10, col.obj) < 1 then
			@y -= @spd
		elseif mad.input\key("down") and mad\checkCol(@, @x, @y+10, col.obj) < 1 then
			@y += @spd

		@x = mad.math.clamp(0, @x, 400 - @w)
		@y = mad.math.clamp(0, @y, 600 - @h)

		super self

	draw: =>
		love.graphics.setColor(@r, @b, @g, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)