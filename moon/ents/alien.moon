export Alien

class Alien extends Entity
	new: (@xpos, @ypos, @s) =>
		--setup
		super @xpos, @ypos
		@w = 32
		@h = 32
		@o_y = @ypos
		@pers = false

		@start = @s
		@ready = false

		--movement vars
		@o_angle = 0
		@o_rad = 25
		@o_spd = 360 / 60
		@dir = @s
		@horspd = 3

	update: (dt) =>
		--horizontal movement
		if @dir == 1 then
			@x += @horspd
		elseif @dir == -1 then
			@x -= @horspd

		--safety
		if @ready then
			if @x > 400 then
				@dir = -@dir
			if @x < 0 then
				@dir = -@dir
		else
			if @start == -1 then
				if @x > 200 then
					@ready = true
			if @start == 1 then
				if @x < 200 then
					@ready = true

		--vertical movement
		@o_angle += @o_spd
		@y = @o_y + @o_rad * math.cos(@o_angle * math.pi / 180)

		super self
	
	draw: =>
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)