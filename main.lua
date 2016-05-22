local Player = require("Player")
local Character = require("Character")
local Level = require("Level")

local player1

function love.load()
	player1 = Player.new(100, 100)
	Level.create("default")
end

function love.update(dt)
	player1:update(dt)
end

function love.draw()
	player1:draw()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end
