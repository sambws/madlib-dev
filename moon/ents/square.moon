export Square

class Square extends Entity
	new: (@xpos, @ypos) =>
		--pos and scale
		super @xpos, @ypos
		@w = 32
		@h = 32
	
		--random vars
		@spd = 2

	update: (dt) =>
		--movement
		if mad\key("left") then
			@x -= @spd
		elseif mad\key("right") then
			@x += @spd
		if mad\key("up") then
			@y -= @spd
		elseif mad\key("down") then
			@y += @spd

		super self
	draw: =>
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)