export Wall

class Wall extends Entity
	new: (@xpos, @ypos) =>
		super @xpos, @ypos
		@w = 32
		@h = 32

		mad\setCollisionGroup(@, col.obj)

	update: (dt) =>
		super self
	
	draw: =>
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)