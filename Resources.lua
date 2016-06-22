local Resources = {}

-- TODO: Levels can be zip files as well as folders.
function Resources.loadLevel(levelName)
	local levelPath = "res/levels/" .. levelName .. "/level.lua"
	print(levelPath)
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

function Resources.loadTileset(levelName)

end

return Resources
