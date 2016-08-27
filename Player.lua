local Resources = require("Resources")
local Controller = require("Controller")
local Sprite = require("Sprite")

local Player = {}
Player.__index = Player

function Player.new(x, y)
	local self = {}
	setmetatable(self, Player)

	self.controller = Controller.new("keyboard")
	self.character = Resources.loadCharacter("chicken")

	-- Set up innate properties.
	self.width = 32
	self.height = 32
	self.walkingVelocity = 100  -- measured in pixels per second
	self.jumpVelocity = -400
	self.fallAccel = 1500			-- measured in pixels per second per second

	-- Set up values for initial state.
	self.currentFrame = 1
	self.facing = 1				-- 1 = right, -1 = left
	self.x = x
	self.y = y
	self.xVelocity = 0
	self.yVelocity = 0
	self.yAccel = 0

	return self
end

function Player:update(dt)
	self:input()
	self.character:update(dt)

	-- Apply acceleration and velocity; set coordinates accordingly.
	self.yVelocity = self.yVelocity + (self.yAccel * dt)
	self.x = self.x + (self.xVelocity * dt)
	self.y = self.y + (self.yVelocity * dt)

	if self:isOnGround() then
		self.yVelocity = 0
		self.yAccel = 0
	else
		self.yAccel = self.fallAccel
	end

	if self.character:getAnim() == "attack" and self.character.animationOver then
		self.character:setAnim("stand")
	end
end

function Player:isOnGround()
	local isOnGround
	local groundLayer = state.level.gnd
	local tileSize = state.level.tileSize
	local playerCol = math.floor(self.x / tileSize)
	local playerRow = math.floor(self.y / tileSize)

	-- If the player is outside the level, then fall.
	if not groundLayer[playerRow] or not groundLayer[playerRow][playerCol] then
		isOnGround = false
	-- Check for ground under the player's feet.
	elseif groundLayer[playerRow][playerCol] == 1 then
		isOnGround = true
	else
		isOnGround = false
	end

	return isOnGround
end

function Player:draw()
	local x = math.floor(self.x)
	local y = math.floor(self.y)

	self.character:draw(x, y, self.facing)
end

function Player:input()
	if self.controller:isDown("right") or self.controller:isDown("left") then
		if self.controller:isDown("right") then
			self.facing = 1
			self.xVelocity = self.walkingVelocity
		elseif self.controller:isDown("left") then
			self.facing = -1
			self.xVelocity = -self.walkingVelocity
		end
		if self.onGround and
		   self.character:getAnim() ~= "walk" and
		   self.character:getAnim() ~= "attack" then
			self.character:setAnim("walk")
		end
	else
		self.xVelocity = 0
		if self.onGround and self.character:getAnim() == "walk" then
			self.character:setAnim("stand")
		end
	end

	if self:isOnGround() and self.controller:isDown("jump") then
		self.yVelocity = self.jumpVelocity
		if self.character:getAnim() ~= "attack" then
			self.character:setAnim("jump")
		end
	end
	if self.onGround and self.character:getAnim() == "jump" then
		self.character:setAnim("stand")
	end

	if self.controller:isDown("attack") and self.character:getAnim() ~= "attack" then
		self.character:setAnim("attack")
	end
end

return Player
