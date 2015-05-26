export Score

class Score extends Entity
	new: (@xpos, @ypos) =>
		super @xpos, @ypos
		@w = 32
		@h = 32

	update: (dt) =>

	draw: =>
		love.graphics.setColor(0, 255, 255, 255)
		love.graphics.print("hey fucko", @x, @y)