local Player = require("Player")
local Level = require("Level")

local player1

function love.load()
	level1 = Level.new("default")
	player1 = Player.new(100, 100)
end

function love.update(dt)
	player1:update(dt)
end

function love.draw()
	level1:draw()
	player1:draw()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end
