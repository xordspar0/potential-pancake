local Level = {}
Level.__index = Level

function Level.load(levelFolder)
	-- TODO: Levels can be zip files as well as folders.
	levelPath = "res/levels/" .. levelFolder .. "/level.lua"
	print(levelPath)
	if not love.filesystem.exists(levelPath) then
		error("Level " .. levelFolder .. " not found.")
	else
		local ok, levelFile = pcall(love.filesystem.load, levelPath)

		if not ok then
			error("There was an error when loading the level file "
			      .. levelFolder .. ": " .. tostring(levelContents))
		else
			local ok, levelContents = pcall(levelFile)

			if not ok then
				error("There was an error when reading the level file "
				      .. levelFolder .. ": " .. tostring(levelContents))
			else
				return levelContents
			end
		end
	end
end

return Level
