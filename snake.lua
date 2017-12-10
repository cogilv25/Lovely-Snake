--! Snake class - The Player is a snake which must conssume food to grow

Snake = Entity:extend()

function Snake:new()
--	Position (X, Y)
	self.pos = Vector(GAMEGRIDSIZE*2,GAMEGRIDSIZE)
--	Dimensions (Width, Height) of a single segment
	self.dim = Vector(GAMEENTITYSIZE,GAMEENTITYSIZE)
--	Direction (X, Y)
	self.dir = Vector(GAMEGRIDSIZE,0)
--	Color (Red, Green, Blue)
	self.color = {255,255,255}
--	Snake Segments (Tail Of the Snake)
	self.segments = {Vector(GAMEGRIDSIZE,GAMEGRIDSIZE),Vector(0,GAMEGRIDSIZE)}
--  Flag to tell snake to grow after feeding
	self.grow = false
--	Direction For Next Frame
	self.nextDir = Vector(GAMEGRIDSIZE,0)
end

function Snake:draw()
	love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.dim.x, self.dim.y)
    for k,v in pairs(self.segments) do
    	love.graphics.rectangle("fill", v.x, v.y, self.dim.x, self.dim.y)
    end
end

function Snake:update()
	local prev = self.pos:getCopy()
	self.pos = self.pos + self.nextDir
	self.dir = self.nextDir
	local newSegments = {}
	for i,v in ipairs(self.segments) do
		newSegments[i] = prev
		prev = v:getCopy()
		--Self Collision Detection
		if(self.pos == v) then
			paused = true
			gameOver = true
		end
	end
	if(self.grow)then
		self.grow = false
		newSegments[#newSegments + 1] = prev
	end
	self.segments = newSegments
	--Wall Collision Detection
	if(self.pos.x == SCREENWIDTH)then
		self.pos.x = 0
	end
	if(self.pos.x < 0)then
		self.pos.x = SCREENWIDTH - GAMEGRIDSIZE
	end
	if(self.pos.y == SCREENHEIGHT)then
		self.pos.y = 0
	end
	if(self.pos.y < 0)then
		self.pos.y = SCREENHEIGHT - GAMEGRIDSIZE
	end
end

function Snake:faceRightNext()
	if(self.dir.x == 0)then
		self.nextDir = Vector(GAMEGRIDSIZE,0)
	end
end

function Snake:faceLeftNext()
	if(self.dir.x == 0)then
		self.nextDir = Vector(-GAMEGRIDSIZE,0)
	end
end

function Snake:faceUpNext()
	if(self.dir.y == 0)then
		self.nextDir = Vector(0,-GAMEGRIDSIZE)
	end
end
	
function Snake:faceDownNext()
	if(self.dir.y == 0)then
		self.nextDir = Vector(0,GAMEGRIDSIZE)
	end
end