export Thing

class Thing extends Entity
	new: (@xpos, @ypos) =>
		super @xpos, @ypos
		@w = 32
		@h = 32

		mad\setCollisionGroup(@, col.player)

	update: (dt) =>
		if mad.col\checkCol(@, @x, @y, col.obj) > 0 then
			print("cool")

		if mad.input\key("left") then
			@x -= 2
		if mad.input\key("right") then
			@x += 2
		if mad.input\key("up") then
			@y -= 2
		if mad.input\key("down") then
			@y += 2

	draw: =>
		love.graphics.setColor(0, 0, 255, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)