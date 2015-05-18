export Bullet

class Bullet extends Entity
	new: (@xpos, @ypos) =>
		--setup
		super @xpos, @ypos
		@w = 16
		@h = 16
		
		--vars
		@spd = 10
	update: (dt) =>
		--vertical movement
		@y -= @spd

		--garbage collecting
		if @y <= 0 - @h then
			mad\removeEnt(self)

		super self
	draw: =>
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)