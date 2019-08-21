-- Food class
require "lib/game/vector"

Food = Object:extend()

function Food:new(x,y,energy)
	self.pos = Vector(x,y)

	-- Energy level when food respawns
	self.energy = energy
	self.eaten = false
end

function Food:update()
	if(self.pos == grid.snake.segments[1])then
		grid:spawnFood()
	elseif(self.pos == grid.snake.segments[#grid.snake.segments])then
		self.eaten = true
	end
	if(self.eaten)then
		if(self.energy < 1)then
			self:respawn()
			self.eaten = false
		else
			score = score + 1
			grid.snake.grow = true
			self.energy = self.energy -1
		end
	end
end