local Level = {}
Level.__index = Level

function Level.load(levelFolder)
	-- TODO: Levels can be zip files as well as folders.
	levelPath = "res/levels/" .. levelFolder
	print(levelPath)
	if not love.filesystem.exists(levelPath) then
		error("Level " .. levelFolder .. " not found.")
	end
end

return Level
