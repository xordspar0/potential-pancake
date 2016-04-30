local Sprite = require("Sprite")

local Chicken = {}
Chicken.__index = Chicken

Chicken.animations = {
	stand = {
		sprite = Sprite.new(
			love.graphics.newImage("res/images/chicken_walk.png"),
			{
				{x = 0, y = 96},
			},
			32, 32,
			5
		),
		loop = true
	},

	walk = {
		sprite = Sprite.new(
			love.graphics.newImage("res/images/chicken_walk.png"),
			{
				{x = 32, y = 96},
				{x = 64, y = 96},
				{x = 96, y = 96},
				{x = 0, y = 96},
			},
			32, 32,
			5
		),
		loop = true
	},

	attack = {
		sprite = Sprite.new(
			love.graphics.newImage("res/images/chicken_eat.png"),
			{
				{x = 0, y = 96},
				{x = 32, y = 96},
				{x = 64, y = 96},
				{x = 96, y = 96},
			},
			32, 32,
			10
		),
		loop = false
	}
}

Chicken.currentAnim = Chicken.animations.stand
Chicken.currentAnimName = "stand"
Chicken.animationOver = false

function Chicken:getAnim()
	return self.currentAnimName
end

function Chicken:setAnim(animation)
	if self.animations[animation] then
		self.currentAnim = self.animations[animation]
		self.currentAnimName = animation
		self.animationOver = false
		self.currentAnim.sprite:resetFrame()
	end
end

function Chicken:update(dt)
	self.currentAnim.sprite:update()

	-- If this is the last frame of the animation, check to see if we should do
	-- anything.
	if self.currentAnim.sprite:atLastFrame() and self.currentAnim.loop == false then
		self.animationOver = true
	end
end

function Chicken:draw(x, y, facing)
	self.currentAnim.sprite:draw(x, y, facing)
end

return setmetatable({}, Chicken)
