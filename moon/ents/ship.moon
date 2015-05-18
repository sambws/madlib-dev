export Ship

class Ship extends Entity
	new: (@xpos, @ypos) =>
		--setup
		super @xpos, @ypos
		@w = 32
		@h = 32
		@pers = true

		--movement vars
		@xvel = 0
		@yvel = 0
		@fric = 10
		@spd = 50

		--random vars
		@zpressed = false
	
	update: (dt) =>
		--movement
		@x = @x + @xvel --add velocities
		@y = @y + @yvel
		@xvel = @xvel * (1 - math.min(dt*@fric, 1)) --calculate velocity
		@yvel = @yvel * (1 - math.min(dt*@fric, 1))

		if mad\key("left") and @xvel < 100 then
			@xvel = @xvel - @spd * dt
		if mad\key("right") and @xvel > -100 then
			@xvel = @xvel + @spd * dt
		if mad\key("up") and @yvel < 100 then
			@yvel = @yvel - @spd * dt
		if mad\key("down") and @yvel > -100 then
			@yvel = @yvel + @spd * dt

		--shooting
		if mad\key("z") then
			if not @zpressed then
				mad\createEnt(Bullet(@x + 8, @y + (@h / 2)))
				@zpressed = true
		else
			@zpressed = false

		--room switch test
		if mad\key("rshift") then
			mad\switchRoom("coolio")

		super self
	
	draw: =>
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)