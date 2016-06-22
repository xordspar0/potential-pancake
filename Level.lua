local Resources = require("Resources")

local Level = {}
Level.__index = Level

function Level.new(levelName)
	self = {}
	setmetatable(self, Level)

	-- Load the level from its file so we can pull in its data.
	local levelFile = Resources.loadLevel(levelName)

	self.name = levelName

	-- Find the layers (bg; TODO: fg, interactable).
	for i, layer in ipairs(levelFile.layers) do
		if layer.type == "tilelayer" and layer.name == "bg" then
			self.bgLayer = layer.data
		end
	end

	-- TODO: Move to a new file called tiles.lua.
	self.tiles = love.graphics.newImage("res/levels/".. levelName .."/tiles.png")
	self.tile1 = love.graphics.newQuad(0, 0, 32, 32, self.tiles:getDimensions())

	return self
end

function Level:draw()
	local x = 0
	local y = 0
	for i, tile in ipairs(self.bgLayer) do

		if tile > 0 then
			love.graphics.draw(self.tiles, self.tile1, x*32, y*32)
		end

		x = x + 1
		if x == 30 then
			x = 0
			y = y + 1
		end
	end
end

return Level
