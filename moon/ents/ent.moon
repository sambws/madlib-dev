--example entity

export Example

class Example extends Entity
	new: (@xpos, @ypos) =>
		--setup
		super @xpos, @ypos
		@w = 32
		@h = 32

		--vars
		@hsp = 2
		@vsp = 2

	update: (dt) =>
		--movin'
		@x += @hsp
		@y += @vsp

		--safety x
		if @x >= (400 - @w) then
			@hsp = -@hsp
		elseif @x <= 0 then
			@hsp = -@hsp

		--safety y
		if @y >= (600 - @h) then
			@vsp = -@vsp
		elseif @y <= 0 then
			@vsp = -@vsp

	draw: =>
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)