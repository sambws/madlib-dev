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

		--sprite
		@sprite, @grid = mad.sprite\gImg('cool.png', 32, 32)

		--define anims
		@anim = mad.sprite\anim(@grid, '1-2', 1, 0.1)

		mad\setCollisionGroup(self, col.obj)

	update: (dt) =>
		--movin'
		--@x += @hsp
		--@y += @vsp

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

		super self

	draw: =>
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle("fill", @x, @y, @w, @h)