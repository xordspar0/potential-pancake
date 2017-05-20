local Camera = {}
Camera.__index = Camera

function Camera.new(x, y, width, height, mode, trackLength, speed)
	local self = {}
	setmetatable(self, Camera)

	self.originX = x
	self.originY = y
	self.x = 0
	self.y = 0
	self.width = width
	self.height = height
	self.length = trackLength
	self.speed = speed

	if mode == "static" or
	   mode == "pan" or
	   mode == "vpan" or
	   mode == "follow" or
	   mode == "path" then
			self.mode = mode
	else
		error(mode .. " is not a valid camera mode")
	end

	return self
end

function Camera:update(dt)
	if self.mode == "pan" then
		if self.x + self.width > self.length or
		   self.x - self.width < self.length then
			self.speed = -self.speed
		end
		self.x = self.x + self.speed*dt
	elseif self.mode == "vpan" then
		if self.y + self.height > self.length or
			self.y < 0 then
			self.speed = -self.speed
		end
		self.y = self.y + self.speed*dt
	elseif self.mode == "follow" then
		error("camera mode follow is not implemented yet")
	elseif self.mode == "path" then
		error("camera mode path is not implemented yet")
	end
end

function Camera:draw(object)
	love.graphics.push()
	love.graphics.translate(-self.x, -self.y)
	love.graphics.setScissor(self.originX, self.originY, self.width, self.height)

	object:draw()

	love.graphics.setScissor()
	love.graphics.pop()
end

return Camera
