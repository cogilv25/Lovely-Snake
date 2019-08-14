-- Written By Calum Lindsay.

-- It is a very simple implementation
-- of the classic snake game I made to
-- try out the LÖVE 2D Game engine. I
-- also made a simple rng "library"
-- called xorshift for spawning food.

-- How to run it:
-- You will need the LÖVE Engine to run
-- it which you can get here:
-- https://love2d.org
-- Download any of the zipped versions,
-- extract them and drag the folder 
-- containing the snake source code
-- onto the "love.exe" executable

-- Controls:
-- Arrow keys or WASD to change direction
-- r to reset
-- p to pause
-- 3 to cheat (snake grows without eating)

--!TODO:
-- 1)Arbitrary window dimensions
-- 2)God mode to test things out
-- 3)I think food should respawn as soon
-- as it's eaten by the head
-- 4)Snake update function could be more 
-- efficient as really only the head and
-- tail need to be modified

SCREENWIDTH = 1200
SCREENHEIGHT = SCREENWIDTH * .75
GAMEGRIDLENGTH = 40
GAMEGRIDHEIGHT = GAMEGRIDLENGTH * .75
GAMEGRIDPOINTSIZE = SCREENWIDTH / GAMEGRIDLENGTH
GAMEGRIDBORDERSIZE = GAMEGRIDPOINTSIZE * .125
GAMEENTITYSIZE = GAMEGRIDPOINTSIZE * .75
GAME_TICK_PERIOD = 0.15
-- Each time the snake eats food the number of
-- segments it grows by increases by this number
FOOD_ENERGY_INCREMENTER = 2

score = 0
highlightedMenuItem = 0
menuHeaderFont = love.graphics.newFont(64)
menuHeader2Font = love.graphics.newFont(32)
menuHeader3Font = love.graphics.newFont(20)

function resetGame()
	gameOver = false
	gameWon = false
	paused = false
	grid:new()
	score = 0
end

function love.load()
	-- Libraries
	Object = require "lib/thirdparty/classic/classic"
	Tick = require "lib/thirdparty/tick/tick"
	Rng = require "lib/xorshift/xorshift"
	-- Classes
	require "grid"

	w,h,flags = love.window.getMode()
	love.window.setMode(SCREENWIDTH,SCREENHEIGHT,flags)
	love.window.setTitle("Snake!")
	love.graphics.setBackgroundColor(0,0,0)
	paused = false
	gameOver = false
	gameWon = false 
	grid = Grid()

	-- Call slowUpdate every GAME_TICK_PERIOD seconds
	Tick.recur(slowUpdate,GAME_TICK_PERIOD)
end

function slowUpdate()
	-- Stop updating entities when paused
	if(paused)then return end
	grid:update()
end

function love.draw()
	grid:draw()
	love.graphics.setColor({1,1,1})
	if paused then
		if gameOver then
			if gameWon then
			love.graphics.setFont(menuHeaderFont)
			love.graphics.printf("You Have Won!", 0, SCREENHEIGHT/menuHeaderFont:getHeight()/2 - 20,SCREENWIDTH,"center")
			love.graphics.setColor({0.623125,0.623125,0.623125})
			love.graphics.setFont(menuHeader2Font)
			love.graphics.printf("Press r to restart", 0, SCREENHEIGHT/2+64,SCREENWIDTH,"center")
			else
			love.graphics.setColor({1,0,0})
			love.graphics.setFont(menuHeaderFont)
			love.graphics.printf("You Have Lost!", 0, SCREENHEIGHT/2-menuHeaderFont:getHeight()/2 - 20,SCREENWIDTH,"center")
			love.graphics.setColor({0.623125,0.623125,0.623125})
			love.graphics.setFont(menuHeader2Font)
			love.graphics.printf("Press r to restart", 0, SCREENHEIGHT/2+44,SCREENWIDTH,"center")
			end
		else
			love.graphics.setFont(menuHeaderFont)
			love.graphics.printf("Paused", SCREENWIDTH/2-200, 5,400,"center")

			if highlightedMenuItem == 1 then
				love.graphics.setColor({1,1,1})
			else
				love.graphics.setColor({0.623125,0.623125,0.623125})
			end
			love.graphics.setFont(menuHeader2Font)
			love.graphics.printf("Continue", SCREENWIDTH/2-200, 75,400,"center")
			if highlightedMenuItem == 2 then
				love.graphics.setColor({1,1,1})
			else
				love.graphics.setColor({0.623125,0.623125,0.623125})
			end
			love.graphics.printf("Exit", SCREENWIDTH/2-200, 115,400,"center")
		end
	else
		love.graphics.setFont(menuHeader3Font)
		love.graphics.printf("Score: " .. score, SCREENWIDTH/2-50, 5,100,"center")
	end
end

function love.update(d)
	Tick.update(d)
	if paused then
		highlightedMenuItem = 0
		if(love.mouse.getX() > SCREENWIDTH/2-200 and love.mouse.getX() < SCREENWIDTH/2+200)then
			if(love.mouse.getY()>75)then
				if(love.mouse.getY() > 115)then
					if(love.mouse.getY() < 160)then
						highlightedMenuItem = 2
						if(love.mouse.isDown(1))then
							love.event.quit()
						end
					end
				else
					highlightedMenuItem = 1
					if(love.mouse.isDown(1))then
						paused = false
					end
				end
			end
		end
	end
end

function love.keypressed(key)
	if(key == "escape")then
		if(not gameOver)then
			paused = not paused
		end
	end
	if(key == "r")then
		resetGame()
	end
	if(key == "up" or key == "w")then
		grid:moveSnakeUpNextFrame()
	end
	if(key == "down" or key == "s")then
		grid:moveSnakeDownNextFrame()
	end
	if(key == "left" or key == "a")then
		grid:moveSnakeLeftNextFrame()
	end
	if(key == "right" or key == "d")then
		grid:moveSnakeRightNextFrame()
	end
	if(key == "3")then
		grid:growSnake = true
	end
end