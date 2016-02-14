local Player = require("Player")
local DialogBox = require("DialogBox")

local screensize = 2
local screenSizeDialog
local player1

function love.load()
	screenSizeDialog = DialogBox.new()
	player1 = Player.new(100, 100)
end

function love.update(dt)
	player1:update(dt)
end

function love.draw()
	--screenSizeDialog:draw()
	player1:draw()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end
