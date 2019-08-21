-- Snake class
require "lib/game/vector"

Snake = Object:extend()

function Snake:new()
	-- Both dir and dirNextFrame are kept track of to prevent the snakes head hitting
	-- the first segment if the player moved right then down in the same frame (doing a uturn on the spot).
	self.dir = Vector(1,0)
	self.dirNextFrame = Vector(1,0)
	self.color = {1,1,1}
	-- Segments is a list of vectors for each snake segment in order from head to tail
	self.segments = {Vector(2,1),Vector(1,1),Vector(0,1)}

	-- Flag to tell snake to grow after feeding
	self.grow = false
end

--- Change ME
function Snake:update()

	-- Update position wrapping around screen
	table.insert(self.segments,1,Vector(
		(self.segments[1].x+self.dirNextFrame.x + GAMEGRIDLENGTH)%GAMEGRIDLENGTH, --New Snake Head X Position
		(self.segments[1].y+self.dirNextFrame.y + GAMEGRIDHEIGHT)%GAMEGRIDHEIGHT  --New Snake Head Y Position
		)
	)
	grid.elements[self.segments[1].y][self.segments[1].x] = 1

	self.dir = self.dirNextFrame

	--Don't remove the last snake segment on moving if the snake is growing
	if(self.grow)then
		self.grow = false
	else
		local old = table.remove(self.segments)
		grid.elements[old.y][old.x] = 0
	end

	for i=2,#self.segments do
		if(self.segments[1] == self.segments[i]) then
			paused = true
			gameOver = true
		end
	end

end

function Snake:faceRight()
	if(self.dir.x == 0)then
		self.dirNextFrame = Vector(1,0)
	end
end

function Snake:faceLeft()
	if(self.dir.x == 0)then
		self.dirNextFrame = Vector(-1,0)
	end
end

function Snake:faceUp()
	if(self.dir.y == 0)then
		self.dirNextFrame = Vector(0,-1)
	end
end
	
function Snake:faceDown()
	if(self.dir.y == 0)then
		self.dirNextFrame = Vector(0,1)
	end
end
