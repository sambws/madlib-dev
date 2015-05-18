export EnemyBullet

class EnemyBullet extends Entity
	new: (@xpos, @ypos) =>
		--setup
		super @xpos, @ypos
		@w = 16
		@h = 16
		mad\setCollisionGroup(self, col.enemyBullet)

		@spd = 10
	update: (dt) =>
		@y += @spd

		--garbage collecting
		if @y >= 600 then
			mad\removeEnt(self)

		super self
	draw: =>
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)
