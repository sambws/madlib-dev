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

			--deadzonin'
			if @haxis <= -0.25 or @haxis >= .25 then
				@x += @haxis * @spd
			if @vaxis <= -0.25 or @vaxis >= .25 then
				@y += @vaxis * @spd

		--keyboard stuff
		if mad.input\key("left") then
			@x -= @spd
		elseif mad.input\key("right") then
			@x += @spd
		if mad.input\key("up") then
			@y -= @spd
		elseif mad.input\key("down") then
			@y += @spd

		super self

	draw: =>
		love.graphics.setColor(@r, @b, @g, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)