export Box

class Box extends Entity
	new: (@xpos, @ypos) =>
		super @xpos, @ypos
		@w = 64
		@h = 64
	
		--vars
		@spd = 4

		--button vars (rbg values)
		@r = 0
		@b = 0
		@g = 0

	update: =>

		--if there's a joystick connected...
		if joysticks[1] ~= nil then
			--do some button stuff
			if mad\joyButton(joystick, "a") then
				@r = 0
			else
				@r = 255
			if mad\joyButton(joystick, "b") then
				@b = 0
			else
				@b = 255
			if mad\joyButton(joystick, "x") then
				@g = 0
			else
				@g = 255

			--constantly assign the movement axis
			@haxis = joystick\getAxis(1)
			@vaxis = joystick\getAxis(2)

			--deadzonin'
			if @haxis <= -.25 or @haxis >= .25 then
				@x += @haxis * @spd
			if @vaxis <= -.25 or @vaxis >= .25 then
				@y += @vaxis * @spd

		--keyboard stuff
		if mad\key("left") then
			@x -= @spd
		elseif mad\key("right") then
			@x += @spd
		if mad\key("up") then
			@y -= @spd
		elseif mad\key("down") then
			@y += @spd

	draw: =>
		love.graphics.setColor(@r, @b, @g, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)