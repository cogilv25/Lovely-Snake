

function love.load()
	--! Include Requirements
	--! Libraries
	Object = require "lib/classic"
	Tick = require "lib/tick"
	--Bit = require "bit"
	Rng = require "lib/xorshift"
	--! Base Classes
	require "base/vector"
	require "base/entity"
	--! High Level Classes
	require "snake"
	--Initialize Love window
	love.window.setTitle("Snake!")
	--love.window.setFullscreen(true)
	love.graphics.setBackgroundColor(0,0,0)
	paused = false
	gameOver = false
	snake = Snake()
	Tick.recur(slowUpdate,0.2)
end

function slowUpdate()
	if(not paused)then
		snake:update()
	end
end

function detectCollisions()
	for k,v in pairs(table_name) do
		print(k,v)
	end
end

function love.draw()
	if(paused)then
		--Pause Menu
	end
	snake:draw()
end

function love.update(d)
	--Continue Updating When Paused
	Tick.update(d)
	if(paused)then return end
	--Stop Updating When Paused
end

function love.keypressed(key)
	if(key == "escape")then
		love.event.quit()
	end
	if(key == "r")then
		--reset game
	end
	if(key == "p" and not gameOver)then
		paused = not paused
	end
	if(key == "left" or key == "a")then
		snake:turnLeft()
	end
	if(key == "right" or key == "d")then
		snake:turnRight()
	end
end