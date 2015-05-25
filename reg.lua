joystick = joysticks[1]
col = {
  player = 0,
  obj = 1
}
path = {
  img = "res/img/",
  snd = "res/snd/",
  dat = "res/dat/"
}
loadLevel = function(filename)
  local fn = path.dat .. filename .. ".txt"
  local file = assert(io.open(fn, "r"))
  local p_x = tonumber(file:read("*line"))
  local p_y = tonumber(file:read("*line"))
  mad.object:createEnt(Box(p_x, p_y))
  local blocks = tonumber(file:read("*line"))
  for i = 1, blocks do
    local _n = tonumber(file:read("*line"))
    local _x = tonumber(file:read("*line"))
    local _y = tonumber(file:read("*line"))
    mad.object:createEnt(Example(_x, _y))
  end
end
