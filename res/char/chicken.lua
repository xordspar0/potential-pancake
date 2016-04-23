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
			15
		),
	}
}

Chicken.currentAnim = Chicken.animations.walk
Chicken.frame = 1

function Chicken:setAnim(animation)
	self.currentAnim = Chicken.animations[animation]
end

function Chicken:update(dt)
	self.currentAnim.sprite:update()
end

function Chicken:draw(x, y, facing)
	self.currentAnim.sprite:draw(x, y, facing)
end

return setmetatable({}, Chicken)
