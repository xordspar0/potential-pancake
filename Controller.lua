local Controller = {}
Controller.__index = Controller

function Controller.new(controllerType)
	local self = setmetatable({}, Controller)

	self.type = controllerType

	if self.type == "keyboard" then
		self.right = "right"
		self.left = "left"
		self.jump = "up"
	end

	return self
end

function Controller:isDown(button)
	if self.type == "keyboard" then
		if button == "right" then
			return love.keyboard.isDown(self.right)
		elseif button == "left" then
			return love.keyboard.isDown(self.left)
		elseif button == "jump" then
			return love.keyboard.isDown(self.jump)
		end
	end
end

return Controller
