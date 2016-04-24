local Sprite = require("Sprite")

local Chicken = {}
Chicken.__index = Chicken

Chicken.animations = {
	walk = {
		sprite = Sprite.new(
			love.graphics.newImage("res/images/chicken_walk.png"), 4,
			32, 32, 0, 96,
			5
		)
	},

	attack = {
		sprite = Sprite.new(
			love.graphics.newImage("res/images/chicken_eat.png"), 4,
			32, 32, 0, 96,
			10
		),
		onEnd = function (self)
			self:setAnim("walk")
		end
	}
}

Chicken.currentAnim = Chicken.animations.walk

function Chicken:setAnim(animation)
	self.currentAnim = Chicken.animations[animation]
	self.currentAnim.sprite:resetFrame()
end

function Chicken:update(dt)
	self.currentAnim.sprite:update()

	-- If this is the last frame of the animation, check to see if we should do
	-- anything.
	if self.currentAnim.sprite:atLastFrame() and self.currentAnim.onEnd then
		self.currentAnim.onEnd(self)
	end
end

function Chicken:draw(x, y, facing)
	self.currentAnim.sprite:draw(x, y, facing)
end

return setmetatable({}, Chicken)
