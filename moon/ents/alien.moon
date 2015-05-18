export Alien

class Alien extends Entity
	new: (@xpos, @ypos, @s) =>
		--setup
		super @xpos, @ypos
		@w = 32
		@h = 32
		@o_y = @ypos
		@pers = false
		mad\setCollisionGroup(self, col.enemy)

		--start will decide what side of default movement dir (1 is left, 1 is right)
		@start = @s
		@ready = false --if it's time to bounce

		--movement vars
		@o_angle = 0
		@o_rad = 25
		@o_spd = 360 / 60
		@dir = @s
		@h_spd = 3

		--shooting
		@shoot_timer = 60

	update: (dt) =>
		--horizontal movement
		if @dir == 1 then
			@x += @h_spd
		elseif @dir == -1 then
			@x -= @h_spd

		--safety
		if @ready then
			if @x > 400 - 32 then
				@dir = -@dir
			if @x < 0 then
				@dir = -@dir
		else
			if @start == 1 then
				if @x > 200 then
					@ready = true
			if @start == -1 then
				if @x < 200 then
					@ready = true

		--vertical movement
		@o_angle += @o_spd
		@y = @o_y + @o_rad * math.cos(@o_angle * math.pi / 180)

		--shooting
		if @shoot_timer ~= 0 then
			@shoot_timer -= 1
		else
			@shoot!
			@shoot_timer = 60

		super self
	
	draw: =>
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)
	
	shoot: =>
		mad\createEnt(EnemyBullet(@x, @y))