-- Grid class
require "lib/game/vector"
require "snake"
require "food"

Grid = Object:extend()

function Grid:new()
	self.elements = {}
	for i = 0 ,GAMEGRIDHEIGHT do
		self.elements[i] = {}
		for j=0 , GAMEGRIDLENGTH do
			self.elements[i][j] = 0
		end
	end
	self.foodRespawnEnergy = 1

	self.snake = Snake()
	self.elements[1][2] = 1;self.elements[1][1] = 1;self.elements[1][0] = 1;

	self.food = {}
	self:spawnFood()
end

function Grid:spawnFood()
	--This will not work well when the grid is nearly full
	local x = Rng:next() % GAMEGRIDLENGTH
	local y = Rng:next() % GAMEGRIDHEIGHT
	while(self.elements[y][x] ~= 0) do
		x = Rng:next() % GAMEGRIDLENGTH
		y = Rng:next() % GAMEGRIDHEIGHT
	end
	
	table.insert(self.food,Food(x,y,FOOD_RESPAWN_ENERGY))
	FOOD_RESPAWN_ENERGY = FOOD_RESPAWN_ENERGY + FOOD_ENERGY_INCREMENTER
	self.elements[y][x] = 2
	
end

function Grid:update()
	self.snake:update()
	for i,v in pairs(self.food)do
		if(v.energy < 1)then
			table.remove(self.food,i)
		else
			v:update()
		end
	end
end

function Grid:draw()
	for i = 0 ,GAMEGRIDHEIGHT do
		for j=0 , GAMEGRIDLENGTH do
			if(self.elements[i][j]==1)then
				love.graphics.setColor({1.0,1.0,1.0})
				love.graphics.rectangle("fill", j*GAMEGRIDPOINTSIZE + GAMEGRIDBORDERSIZE, i*GAMEGRIDPOINTSIZE + GAMEGRIDBORDERSIZE, GAMEENTITYSIZE, GAMEENTITYSIZE)
			elseif(self.elements[i][j]==2)then
				love.graphics.setColor({1.0,1.0,0.0})
				love.graphics.rectangle("fill", j*GAMEGRIDPOINTSIZE + GAMEGRIDBORDERSIZE, i*GAMEGRIDPOINTSIZE + GAMEGRIDBORDERSIZE, GAMEENTITYSIZE, GAMEENTITYSIZE)
			end
		end
	end
end