local Controller = require("Controller")

local Player = {}
Player.__index = Player

local debugGround = 400

function Player.new(x, y)
	local self = setmetatable({}, Player)

	self.controller = Controller.new("keyboard")

	-- Set up the sprite.
	self.image = love.graphics.newImage("res/images/chicken_walk.png")
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

	-- Set up innate properties.
	self.yAccel = 1500			-- measured in pixels per second per second
	self.walkingVelocity = 150  -- measured in pixels per second
	self.jumpVelocity = -400

	-- Set up values for initial state.
	self.currentFrame = 1
	self.facing = 1				-- 1 = right, -1 = left
	self.x = x
	self.y = y
	self.xVelocity = 0
	self.yVelocity = 0
	self.onGround = false
	
	return self
end

function Player:update(dt)
	self.currentFrame = math.floor(self.framesPerSecond * love.timer.getTime() % self.numFrames + 1)
	self:input()
	
	-- Apply acceleration and velocity; set coordinates accordingly.
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
	if self.controller:isDown("right") then
		self.facing = 1
		self.xVelocity = self.walkingVelocity
	elseif self.controller:isDown("left") then
		self.facing = -1
		self.xVelocity = -self.walkingVelocity
	else
		self.xVelocity = 0
	end
	if self.onGround and self.controller:isDown("jump") then
		self.onGround = false
		self.yVelocity = self.jumpVelocity
	end
end

return Player
