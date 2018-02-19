local resources = require("resources")
local tileset = require("tileset")

local level = {}
level.__index = level

level.tileSize = 32

local function foldTable(longTable, width)
	foldedTable = {}

	row = 1
	col = 1
	foldedTable[row] = {}
	for i, value in ipairs(longTable) do
		foldedTable[row][col] = value

		col = col + 1
		if col > width then
			row = row + 1
			col = 1
			foldedTable[row] = {}
		end
	end

	return foldedTable
end

function level.new(levelName)
	local self = {}
	setmetatable(self, level)

	-- Load the level from its file so we can pull in its data.
	local levelFile = resources.loadLevel(levelName)

	self.name = levelName

	for i, layer in ipairs(levelFile.layers) do
		if layer.type == "tilelayer" and layer.name == "gnd" then
			self.gnd = foldTable(layer.data, layer.width)
		elseif layer.type == "tilelayer" and layer.name == "bg" then
			self.bg = foldTable(layer.data, layer.width)
		elseif layer.type == "tilelayer" and layer.name == "obj" then
			self.obj = foldTable(layer.data, layer.width)
		elseif layer.type == "tilelayer" and layer.name == "fg" then
			self.fg = foldTable(layer.data, layer.width)
		end
	end

	self.width = #self.gnd[1] * self.tileSize
	self.height = #self.gnd * self.tileSize

	self.tiles = tileset.new(levelName)

	self.music = resources.loadMusic(levelName)
	self.music:setLooping(true)

	return self
end

function level:draw()
	-- Draw the background.
	for rowIndex, row in ipairs(self.bg) do
		for colIndex, tileNumber in ipairs(row) do
			if tileNumber > 0 then
				love.graphics.draw(
				self.tiles.spritesheet, self.tiles.tile[tileNumber],
				colIndex * self.tileSize, rowIndex * self.tileSize)
			end
		end
	end
	-- Draw the objects.
	for rowIndex, row in ipairs(self.obj) do
		for colIndex, tileNumber in ipairs(row) do
			if tileNumber > 0 then
				love.graphics.draw(
				self.tiles.spritesheet, self.tiles.tile[tileNumber],
				colIndex * self.tileSize, rowIndex * self.tileSize)
			end
		end
	end
	-- Draw the foreground.
	for rowIndex, row in ipairs(self.fg) do
		for colIndex, tileNumber in ipairs(row) do
			if tileNumber > 0 then
				love.graphics.draw(
				self.tiles.spritesheet, self.tiles.tile[tileNumber],
				colIndex * self.tileSize, rowIndex * self.tileSize)
			end
		end
	end

end

return level
