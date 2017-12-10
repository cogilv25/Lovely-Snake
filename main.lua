SCREENWIDTH = 800
SCREENHEIGHT = 600
GAMEENTITYSIZE = 15
GAMEGRIDSIZE = 20

function resetGame()
	gameOver = false
	paused = false
	snake:new()
	food:respawn()
end

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
	require "food"
	--Initialize Love window
	love.window.setTitle("Snake!")
	--love.window.setFullscreen(true)
	love.graphics.setBackgroundColor(0,0,0)
	paused = false
	gameOver = false
	snake = Snake()
	food = Food()
	Tick.recur(slowUpdate,0.15)
end

function slowUpdate()
	--Using the tick library to slow down the framerate
	if(paused)then return end
	snake:update()
	food:update()
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
	food:draw()
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
		resetGame()
	end
	if(key == "p" and not gameOver)then
		paused = not paused
	end
	if(key == "up" or key == "w")then
		snake:faceUpNext()
	end
	if(key == "down" or key == "s")then
		snake:faceDownNext()
	end
	if(key == "left" or key == "a")then
		snake:faceLeftNext()
	end
	if(key == "right" or key == "d")then
		snake:faceRightNext()
	end
end