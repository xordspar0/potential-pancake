local Player = require("Player")
local Level = require("Level")

state = {}

function love.load()
	state.level = Level.new("fluffy")
	state.level.music:play()

	state.players = {}
	state.players[1] = Player.new(200, 10)
end

function love.update(dt)
	for i, player in ipairs(state.players) do
		player:update(dt)
	end
end

function love.draw()
	state.level:draw()

	for i, player in ipairs(state.players) do
		player:draw()
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end
