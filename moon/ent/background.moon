export Background

class Background extends Entity
	new: (@xpos, @ypos) =>
		super @xpos, @ypos
		@w = love.graphics.getWidth()
		@h = love.graphics.getHeight()

		@pressed = false
		@persistent = true

	update: (dt) =>
		if mad.input\key("z") then
			if not @pressed
				mad.room\switchRoom("donkey")
				@pressed = true

	draw: =>