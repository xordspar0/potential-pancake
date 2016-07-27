local Resources = {}

local characterDir = "res/char/"
local levelDir = "res/levels/"

function Resources.loadCharacter(characterName)
	for i, file in ipairs(love.filesystem.getDirectoryItems(characterDir)) do
		if string.sub(file, -4, -1) == ".lua" and string.sub(file, 1, -5) == characterName then
			print("Found character: " .. characterName)
			return require(characterDir .. characterName)
		end
	end
end

-- TODO: Levels can be zip files as well as folders.
function Resources.loadLevel(levelName)
	local levelPath = levelDir .. levelName .. "/level.lua"
	if not love.filesystem.exists(levelPath) then
		error("Level " .. levelName .. " not found.")
	else
		local ok, levelFile = pcall(love.filesystem.load, levelPath)

		if not ok then
			error("There was an error when loading level "
				  .. levelName .. ": " .. tostring(levelFile))
		else
			local ok, levelContents = pcall(levelFile)

			if not ok then
				error("There was an error when reading level "
					  .. levelName .. ": " .. tostring(levelContents))
			else
				return levelContents
			end
		end
	end
end

-- TODO: Look up tilesets in multiple locations according to /docs/tilesets.md
function Resources.loadTileset(tilesetName)
	local tilesetPath = levelDir .. tilesetName .. "/tiles.png"
	if not love.filesystem.exists(tilesetPath) then
		error("Tileset " .. tilesetName .. " not found.")
	else
		return love.graphics.newImage(tilesetPath)
	end
end

return Resources
