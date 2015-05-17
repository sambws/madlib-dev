export Square

class Square
	new: (@xpos, @ypos) =>
		@x = @xpos
		@y = @ypos
	update: (dt) =>
		@x += 2
	draw: =>
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle("fill", @x, @y, 32, 32)