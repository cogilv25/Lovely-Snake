-- Grid class
require "lib/game/vector"

Grid = Object:extend()

function Grid:new()
	self.elements = {}
	for i = 1 ,GAMEGRIDHEIGHT do
		self.elements[i] = {}
		for j=1 , GAMEGRIDLENGTH do
			self.elements[i][j] = 0
		end
	end
	self.foodRespawnEnergy = 1
	self.foodEnergy = 1
	self.foodEaten = false
end

function Grid:respawnFood()
	-- This is pretty inefficient but it works for now
	local allowedSpaces = {}
	for i=1,GAMEGRIDLENGTH*GAMEGRIDHEIGHT do
		allowedSpaces[i] = Vector(i%GAMEGRIDLENGTH*GAMEGRIDPOINTSIZE,
			math.floor(i/GAMEGRIDLENGTH)*GAMEGRIDPOINTSIZE)
	end

	local i = (Rng:next() % #allowedSpaces)
	self.pos = allowedSpaces[i]
	self.respawnEnergy = self.respawnEnergy + FOOD_ENERGY_INCREMENTER
	self.energy = self.respawnEnergy
	self.eaten = false
end

function Grid:update()
	
end

function Grid:draw()
	for i = 1 ,GAMEGRIDHEIGHT do
		for j=1 , GAMEGRIDLENGTH do
			if(elements[i][j]==1)then
				love.graphics.setcolor({1.0,1.0,1.0})
				love.graphics.rectangle("fill", j*GAMEGRIDPOINTSIZE + GAMEGRIDBORDERSIZE, i*GAMEGRIDPOINTSIZE + GAMEGRIDBORDERSIZE, GAMEENTITYSIZE, GAMEENTITYSIZE)
			elseif(elements[i][j]==2)then
				love.graphics.setcolor({1.0,1.0,0.0})
				love.graphics.rectangle("fill", j*GAMEGRIDPOINTSIZE + GAMEGRIDBORDERSIZE, i*GAMEGRIDPOINTSIZE + GAMEGRIDBORDERSIZE, GAMEENTITYSIZE, GAMEENTITYSIZE)
			end
		end
	end
end

--[[
	Old Snake Class Code



-- Snake class
require "lib/game/vector"

Snake = Object:extend()

function Snake:new()
	self.pos = Vector(GAMEGRIDPOINTSIZE*2,GAMEGRIDPOINTSIZE)
	self.dim = Vector(GAMEENTITYSIZE,GAMEENTITYSIZE)
	-- Both dir and dirNextFrame are kept track of to prevent the snakes head hitting
	-- the first segment if the player moved right then down in the same frame (doing a uturn on the spot).
	self.dir = Vector(GAMEGRIDPOINTSIZE,0)
	self.dirNextFrame = Vector(GAMEGRIDPOINTSIZE,0)
	self.color = {1,1,1}
	-- Segments is just a list of vectors in order from head to tail
	self.segments = {Vector(GAMEGRIDPOINTSIZE,GAMEGRIDPOINTSIZE),Vector(0,GAMEGRIDPOINTSIZE)}
	-- Flag to tell snake to grow after feeding
	self.grow = false
end

function Snake:draw()
	love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x + GAMEGRIDBORDERSIZE, self.pos.y + GAMEGRIDBORDERSIZE, self.dim.x, self.dim.y)
    for k,v in pairs(self.segments) do
    	love.graphics.rectangle("fill", v.x + GAMEGRIDBORDERSIZE, v.y + GAMEGRIDBORDERSIZE, self.dim.x, self.dim.y)
    end
end

function Snake:update()
	local prev = self.pos:getCopy()
	-- Update position wrapping around screen
	self.pos.x = (self.pos.x + self.dirNextFrame.x + SCREENWIDTH) % SCREENWIDTH
	self.pos.y = (self.pos.y + self.dirNextFrame.y + SCREENHEIGHT) % SCREENHEIGHT
	self.dir = self.dirNextFrame
	local newSegments = {}
	for i,vec in ipairs(self.segments) do
		newSegments[i] = prev
		prev = vec
		-- Self Collision Detection
		if(self.pos == vec) then
			paused = true
			gameOver = true
		end
	end
	if(self.grow)then
		self.grow = false
		newSegments[#newSegments + 1] = prev
	end
	self.segments = newSegments
end

function Snake:moveRightNextFrame()
	if(self.dir.x == 0)then
		self.dirNextFrame = Vector(GAMEGRIDPOINTSIZE,0)
	end
end

function Snake:moveLeftNextFrame()
	if(self.dir.x == 0)then
		self.dirNextFrame = Vector(-GAMEGRIDPOINTSIZE,0)
	end
end

function Snake:moveUpNextFrame()
	if(self.dir.y == 0)then
		self.dirNextFrame = Vector(0,-GAMEGRIDPOINTSIZE)
	end
end
	
function Snake:moveDownNextFrame()
	if(self.dir.y == 0)then
		self.dirNextFrame = Vector(0,GAMEGRIDPOINTSIZE)
	end
end


]]--



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--[[
	Old Food Class Code



-- Food class
require "lib/game/vector"

Food = Object:extend()

function Food:new()
	--Spawn food randomly on grid
	local xrange = SCREENWIDTH/GAMEGRIDPOINTSIZE - 1
	local yrange = SCREENHEIGHT/GAMEGRIDPOINTSIZE - 1 
	local x = (Rng:next() % xrange) * GAMEGRIDPOINTSIZE
	local y = (Rng:next() % yrange) * GAMEGRIDPOINTSIZE
	self.pos = Vector(x,y)
	
	self.dim = Vector(GAMEENTITYSIZE,GAMEENTITYSIZE)
	self.color = {1,1,0}
	-- Energy level when food respawns
	self.respawnEnergy = 1
	self.energy = 1
	self.eaten = false
end

function Food:respawn()
	-- This is pretty inefficient but it works for now
	local allowedSpaces = {}
	for i=1,GAMEGRIDLENGTH*GAMEGRIDHEIGHT do
		allowedSpaces[i] = Vector(i%GAMEGRIDLENGTH*GAMEGRIDPOINTSIZE,
			math.floor(i/GAMEGRIDLENGTH)*GAMEGRIDPOINTSIZE)
	end

	for i,v in ipairs(snake.segments) do
		table.remove(allowedSpaces,(v.x/GAMEGRIDPOINTSIZE)+(v.y/GAMEGRIDPOINTSIZE)*GAMEGRIDLENGTH)
	end

	local i = (Rng:next() % #allowedSpaces)
	self.pos = allowedSpaces[i]
	self.respawnEnergy = self.respawnEnergy + FOOD_ENERGY_INCREMENTER
	self.energy = self.respawnEnergy
	self.eaten = false
end

function Food:update()
	if(self.pos == snake.segments[#snake.segments])then
		self.eaten = true
	end
	if(self.eaten)then
		if(self.energy < 1)then
			self:respawn()
			self.eaten = false
		else
			if score == GAMEGRIDLENGTH*GAMEGRIDHEIGHT-1 then
				paused = true
				gameOver = true
				gameWon = true
			end
			score = score + 1
			snake.grow = true
			self.energy = self.energy -1
		end
	end
end

function Food:draw()
	love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x + GAMEGRIDBORDERSIZE, self.pos.y + GAMEGRIDBORDERSIZE, self.dim.x, self.dim.y)
end


]]--