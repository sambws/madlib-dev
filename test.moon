export Test

class Test
	new: (@xpos, @ypos) =>
		@x = @xpos
		@y = @ypos
		@w = 64
		@h = 64
		@z = -@ypos
	update: (dt) =>
		
	draw: =>
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)