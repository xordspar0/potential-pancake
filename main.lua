local Camera = require("Camera")
local Player = require("Player")
local Level = require("Level")

state = {}

function love.load()
	state.level = Level.new("fluffy")
	state.level.music:play()
	state.cameras = {
		Camera.new(0, 0, love.graphics.getWidth(), love.graphics.getHeight(),
		           "vpan", state.level.height, 10),
	}

	state.players = {}
	state.players[1] = Player.new(200, 10)
end

function love.update(dt)
	for i, player in ipairs(state.players) do
		player:update(dt)
	end

	for i, camera in ipairs(state.cameras) do
		camera:update(dt)
	end
end

function love.draw()
	for i, camera in ipairs(state.cameras) do
		camera:draw(state.level)

		for i, player in ipairs(state.players) do
			camera:draw(player)
		end
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end
