Food = Entity:extend()

function Food:new()
	local xrange, yrange = SCREENWIDTH/GAMEGRIDSIZE - 1, SCREENHEIGHT/GAMEGRIDSIZE - 1 
	local x,y = (Rng:next() % xrange) * GAMEGRIDSIZE,(Rng:next() % yrange) * GAMEGRIDSIZE
	--Position
	self.pos = Vector(x,y)
	--Dimensions
	self.dim = Vector(GAMEENTITYSIZE,GAMEENTITYSIZE)
	--Food is yellow
	self.color = {255,255,0}
end

function Food:respawn()
	local xrange = SCREENWIDTH/GAMEGRIDSIZE - 1
	print(xrange)
	local yrange = SCREENHEIGHT/GAMEGRIDSIZE - 1 
	local x = Rng:next()
	print(x)
	x = x % xrange
	print(x)
	x = x * GAMEGRIDSIZE
	local y = (Rng:next() % yrange) * GAMEGRIDSIZE
	self.pos = Vector(x,y)
end

function Food:update()
	if(self.pos == snake.segments[#snake.segments])then
		self:respawn()
		snake.grow = true
	end
end