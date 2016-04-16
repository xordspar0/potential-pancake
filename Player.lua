local Controller = require("Controller")
local Sprite = require("Sprite")

local Player = {}
Player.__index = Player

local debugGround = 400

function Player.new(x, y)
	local self = {}
	setmetatable(self, Player)

	self.controller = Controller.new("keyboard")

	self.walkAnim = Sprite.new(
		love.graphics.newImage("res/images/chicken_walk.png"), 4,
		32, 32, 0, 96,
		5
	)
	self.attackAnim = Sprite.new(
		love.graphics.newImage("res/images/chicken_eat.png"), 4,
		32, 32, 0, 96,
		15
	)

	self.currentAnim = self.walkAnim

	-- Set up innate properties.
	self.width = 32
	self.height = 32
	self.walkingVelocity = 150  -- measured in pixels per second
	self.jumpVelocity = -400
	self.yAccel = 1500			-- measured in pixels per second per second

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
	self:input()
	self.currentAnim:update(dt)
	
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
	local x = math.floor(self.x)
	local y = math.floor(self.y)
	self.currentAnim:draw(x, y, self.facing)
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
	if self.controller:isDown("attack") then
		self.currentAnim = self.attackAnim
	end
end

return Player
