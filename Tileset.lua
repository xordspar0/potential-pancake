local Resources = require("Resources")

local Tileset = {}
Tileset.__index = Tileset

local tileHeight = 32
local tileWidth = 32

function Tileset.new(fileName)
	local self = {}
	setmetatable(self, Tileset)

	self.spritesheet = Resources.loadTileset(fileName)

	-- Divide the spritesheet up into individual tiles.
	self.tile = {}
	local i = 1
	for row=0,15 do
		for col=0,15 do
			local x = tileHeight * col
			local y = tileWidth * row
			self.tile[i] = love.graphics.newQuad(
				x, y, tileHeight, tileWidth,
				self.spritesheet:getDimensions())
			i = i+1
		end
	end

	return self
end

return Tileset
