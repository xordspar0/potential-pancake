local Resources = require("Resources")
local Tileset = require("Tileset")
local Util = require("util")

local Level = {}
Level.__index = Level

Level.tileSize = 32

function Level.new(levelName)
	local self = {}
	setmetatable(self, Level)

	-- Load the level from its file so we can pull in its data.
	local levelFile = Resources.loadLevel(levelName)

	self.name = levelName

	for i, layer in ipairs(levelFile.layers) do
		if layer.type == "tilelayer" and layer.name == "bg" then
			self.bg = Util.foldTable(layer.data, layer.width)
		elseif layer.type == "tilelayer" and layer.name == "gnd" then
			self.gnd = Util.foldTable(layer.data, layer.width)
		end
	end

	self.tiles = Tileset.new(levelName)

	return self
end

function Level:draw()
	for rowIndex, row in ipairs(self.bg) do
		for colIndex, tileNumber in ipairs(row) do
			if tileNumber > 0 then
				love.graphics.draw(
				self.tiles.spritesheet, self.tiles.tile[tileNumber],
				colIndex * self.tileSize, rowIndex * self.tileSize)
			end
		end
	end
end

return Level
