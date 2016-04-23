local Character = {}

local charactersDir = "res/char/"

function Character.new(characterName)
	for i, file in ipairs(love.filesystem.getDirectoryItems(charactersDir)) do
		if string.sub(file, -4, -1) == ".lua" and string.sub(file, 1, -5) == characterName then
			print("Found character: " .. characterName)
			return require(charactersDir .. characterName)
		end
	end
end

return Character
