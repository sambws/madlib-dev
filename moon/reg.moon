--this file is like a global registry for random stuff you might need throughout your project.
--any entity can aquire these things, and the file itself is required from main.moon

export col, path
export joystick

--set up controllers here
joystick = joysticks[1]

--collision groups
col = {
	player: 0
	obj: 1
	--add more collision groups here!
}

--resource paths
path = {
	img: "res/img/"
	snd: "res/snd/"
	--add any other external resource paths here!
}

--this will read the file for a level, loading in the player and all blocks
export loadLevel = (filename) ->
	fn = filename .. ".txt"
	file = assert(io.open(fn, "r"))
	
	--create player
	p_x = tonumber(file\read("*line"))
	p_y = tonumber(file\read("*line"))
	mad.object\createEnt(Box(p_x, p_y))

	--create blocks
	blocks = tonumber(file\read("*line"))
	for i=1, blocks
		_x = tonumber(file\read("*line"))
		_y = tonumber(file\read("*line"))
		mad.object\createEnt(Example(_x, _y))