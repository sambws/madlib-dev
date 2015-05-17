export Square

class Square
	new: (@xpos, @ypos) =>
		@x = @xpos
		@y = @ypos
		@w = 32
		@h = 32
		@z = -@ypos
		@spd = 2
	update: (dt) =>
		if mad\key("left") then
			@x -= @spd
		elseif mad\key("right") then
			@x += @spd
		if mad\key("up") then
			@y -= @spd
		elseif mad\key("down") then
			@y += @spd

		mad\zord(self)
	draw: =>
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)