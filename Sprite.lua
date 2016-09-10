local Sprite = {}
Sprite.__index = Sprite

function Sprite.new(image, frames, frameWidth, frameHeight, feetHeight, fps)
	local self = {}
	setmetatable(self, Sprite)

	self.image = image
	self.numFrames = #frames
	self.frameWidth = frameWidth
	self.frameHeight = frameHeight
	self.feetHeight = feetHeight
	self.framesPerSecond = fps

	self.frames = {}
	for i, frame in ipairs(frames) do
		self.frames[i] = love.graphics.newQuad(
			frame.x, frame.y, self.frameWidth, self.frameHeight,
			self.image:getDimensions()
		)
	end
	self:resetFrame()

	return self
end

function Sprite:atLastFrame()
	return self.currentFrame == self.numFrames
end

function Sprite:resetFrame()
	self.startTime = love.timer.getTime()
	self.currentFrame = math.floor(
		(self.framesPerSecond * (love.timer.getTime() - self.startTime))
		% self.numFrames) + 1
end

function Sprite:update(dt)
	self.currentFrame = math.floor(
		(self.framesPerSecond * (love.timer.getTime() - self.startTime))
		% self.numFrames) + 1
end

function Sprite:draw(x, y, facing)
	love.graphics.draw(
		self.image, self.frames[self.currentFrame],
		x, y,
		0, facing, 1, self.frameWidth/2, self.frameHeight - self.feetHeight)
end

return Sprite
