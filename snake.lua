-- Snake class
require "lib/game/vector"

Snake = Object:extend()

function Snake:new()
	self.pos = Vector(GAMEGRIDPOINTSIZE*2,GAMEGRIDPOINTSIZE)
	self.dim = Vector(GAMEENTITYSIZE,GAMEENTITYSIZE)
	-- Both dir and dirNextFrame are kept track of to prevent the snakes head hitting
	-- the first segment if the player moved right then down in the same frame.
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