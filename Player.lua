local Player = {}
Player.__index = Player

local debugGround = 400

function Player.new(x, y)
	local self = setmetatable({}, Player)

	-- Set up the sprite.
	self.image = love.graphics.newImage("chicken_walk.png")
	self.numFrames = 4
	self.framesPerSecond = 5
	self.frames = {}
	self.width = 32
	self.height = 32
	local startingX = 0
	local startingY = 96
	for i = 1, self.numFrames do
		self.frames[i] = love.graphics.newQuad(startingX + (i-1)*self.width,
			startingY, self.width, self.height, self.image:getDimensions())
	end

	-- Set up physics values.
	self.currentFrame = 1
	self.facing = 1				-- 1 = right, -1 = left
	self.x = x
	self.y = y
	self.xVelocity = 0			-- measured in pixels per second
	self.yVelocity = 0
	self.yAccel = 1000			-- measured in pixels per second per second
	self.onGround = false
	
	return self
end

function Player:update(dt)
	self.currentFrame = math.floor(self.framesPerSecond * love.timer.getTime() % self.numFrames + 1)
	self:input()
	
	-- apply acceleration and velocity, set coordinates accordingly
	self.yVelocity = self.yVelocity + (self.yAccel * dt)
	self.x = self.x + (self.xVelocity * dt)
	self.y = self.y + (self.yVelocity * dt)
	
	if self.y >= debugGround - 1 then
		self.y = debugGround - 1
	end
	
	if not self.onGround and self.y >= debugGround - 1 then
		self.onGround = true
		self.yVelocity = 0
	end
end

function Player:draw()
	love.graphics.draw(
		self.image, self.frames[self.currentFrame],
		math.floor(self.x), math.floor(self.y),
		0, self.facing, 1, self.width/2, self.height)
end

function Player:input()
	if love.keyboard.isDown("right") then
		self.facing = 1
		self.xVelocity = 100
	elseif love.keyboard.isDown("left") then
		self.facing = -1
		self.xVelocity = -100
	else
		self.xVelocity = 0
	end
	if self.onGround and love.keyboard.isDown("up") then
		self.onGround = false
		self.yVelocity = -300
	end
end

return Player
