local Sprite = {}
Sprite.__index = Sprite

function Sprite.new(image, numFrames, frameWidth, frameHeight, x, y, fps)
	local self = {}
	setmetatable(self, Sprite)

	self.image = image
	self.numFrames = numFrames
	self.frameWidth = frameWidth
	self.frameHeight = frameHeight
	self.framesPerSecond = fps

	self.frames = {}
	for i = 1, self.numFrames do
		self.frames[i] = love.graphics.newQuad(
			x + (i-1) * self.frameWidth,
			y, self.frameWidth, self.frameHeight,
			self.image:getDimensions()
		)
	end
	self.currentFrame = 1

	return self
end

function Sprite:atLastFrame()
	return self.currentFram == self.numFrames
end

function Sprite:update(dt)
	self.currentFrame = math.floor(self.framesPerSecond * love.timer.getTime() % self.numFrames + 1)
end

function Sprite:draw(x, y, facing)
	love.graphics.draw(
		self.image, self.frames[self.currentFrame],
		x, y,
		0, facing, 1, self.frameWidth/2, self.frameHeight)
end

return Sprite
