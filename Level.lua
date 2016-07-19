local Resources = require("Resources")
local Tileset = require("Tileset")

local Level = {}
Level.__index = Level

function Level.new(levelName)
	local self = {}
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

	self.tiles = Tileset.new("res/levels/" .. levelName .. "/tiles.png")

	return self
end

function Level:draw()
	local x = 0
	local y = 0
	for i, tileNumber in ipairs(self.bgLayer) do

		if tileNumber > 0 then
			love.graphics.draw(
				self.tiles.spritesheet, self.tiles.tile[tileNumber],
				x*32, y*32)
		end

		x = x + 1
		if x == 30 then
			x = 0
			y = y + 1
		end
	end
end

return Level
