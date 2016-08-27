local Util = {}

function Util.foldTable(longTable, width)
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

return Util
