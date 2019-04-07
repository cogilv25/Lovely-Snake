-- Food class
Food = Object:extend()

function Food:new()
	--Spawn food randomly on grid
	local xrange = SCREENWIDTH/GAMEGRIDSIZE - 1
	local yrange = SCREENHEIGHT/GAMEGRIDSIZE - 1 
	local x = (Rng:next() % xrange) * GAMEGRIDSIZE
	local y = (Rng:next() % yrange) * GAMEGRIDSIZE
	self.pos = Vector(x,y)
	
	self.dim = Vector(GAMEENTITYSIZE,GAMEENTITYSIZE)
	self.color = {255,255,0}
	-- Energy level when food respawns
	self.respawnEnergy = 1
	self.energy = 1
	self.eaten = false
end

function Food:respawn()
	local xrange = SCREENWIDTH/GAMEGRIDSIZE - 1
	local yrange = SCREENHEIGHT/GAMEGRIDSIZE - 1 
	local x = (Rng:next() % xrange) * GAMEGRIDSIZE
	local y = (Rng:next() % yrange) * GAMEGRIDSIZE
	self.pos = Vector(x,y)
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
			snake.grow = true
			self.energy = self.energy -1
		end
	end
end

function Food:draw()
	love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.dim.x, self.dim.y)
end