export BigBox

class BigBox extends Entity
	new: (@xpos, @ypos) =>
		super @xpos, @ypos
		@w = 64
		@h = 64
	update: (dt) =>
		super self
	draw: =>
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)