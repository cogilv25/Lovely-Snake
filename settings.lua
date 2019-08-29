--Settings file
--Convienent place to change  

--COLORS
SNAKE_COLOR = {1,1,1}
FOOD_COLOR = {1,1,0}
TEXT_SELECTED_COLOR = {1,1,1}
TEXT_UNSELECTED_COLOR = {0.623125,0.623125,0.623125}
TEXT_WIN_MESSAGE_COLOR = {0,1,0}
TEXT_LOSE_MESSAGE_COLOR = {1,0,0}
TEXT_RESTART_MESSAGE_COLOR = {0.623125,0.623125,0.623125}
TEXT_SCORE_MESSAGE_COLOR = {1,1,1}

--DIMENSIONS

	--APPLICATION
	SCREENWIDTH = 1200
	SCREENHEIGHT = SCREENWIDTH * .75

	--TEXT
	TEXT_HEADER_FONT = love.graphics.newFont(64)
	TEXT_HEADER2_FONT = love.graphics.newFont(32)
	TEXT_HEADER3_FONT = love.graphics.newFont(20)
	TEXT_FONT = love.graphics.newFont(14)

	--GAME
	GAMEGRIDLENGTH = 40
	GAMEGRIDHEIGHT = 30
	GAMEGRIDPOINTSIZE = SCREENWIDTH / GAMEGRIDLENGTH
	GAMEGRIDBORDERSIZE = GAMEGRIDPOINTSIZE * .125
	GAMEENTITYSIZE = GAMEGRIDPOINTSIZE * .75


--GAMEPLAY
GAME_TICK_PERIOD = 0.15
-- Each time the snake eats food the number of
-- segments it grows by increases by this number
FOOD_ENERGY_INCREMENTER = 2
-- Initial food energy
FOOD_RESPAWN_ENERGY = 1

GAME_WINNING_SCORE = GAMEGRIDLENGTH * GAMEGRIDHEIGHT * 0.98
