local DialogBox = {}
DialogBox.__index = DialogBox

function DialogBox.new()
	local self = {}
	setmetatable(self, DialogBox)

	local windowWidth, windowHeight = love.window.getMode()
	self.dialogWidth = windowWidth / 3
	self.dialogHeight = windowHeight / 3
	self.dialogX = windowWidth / 2 - self.dialogWidth / 2
	self.dialogY = windowHeight / 2 - self.dialogHeight / 2

	return self
end

function DialogBox:draw()
	love.graphics.setColor(100,100,100)
	love.graphics.rectangle("fill", self.dialogX, self.dialogY, self.dialogWidth, self.dialogHeight)
	love.graphics.setColor(255,255,255)
	love.graphics.circle("fill", self.dialogX + 15, self.dialogY + 15, 6, 25)
	love.graphics.setColor(0,0,0)
end

return DialogBox
