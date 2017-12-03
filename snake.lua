--! Snake class - The Player is a snake which must conssume food to grow

Snake = Entity:extend()

function Snake:new()
--	Position (X, Y)
	self.pos = Vector(48,48)
--	Dimensions (Width, Height)
	self.dim = Vector(7,7)
--	Direction (X, Y)
	self.dir = Vector(8,0)
--	Color (Red, Green, Blue)
	self.color = {255,255,255}
--	Snake Segments (Tail Of the Snake)
	self.segments = {Vector(40,48),Vector(32,48)}
end

function Snake:draw()
	love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.dim.x, self.dim.y)
    for k,v in pairs(self.segments) do
    	love.graphics.rectangle("fill", v.x, v.y, self.dim.x, self.dim.y)
    end
end

function Snake:update(dt)
	local prev = self.pos
	local newSegments = {}
	for i,v in ipairs(self.segments) do
		newSegments[i] = prev:getCopy()
		prev = v
	end
	self.segments = newSegments
	self.pos = self.pos + self.dir
end

function Snake:turnRight()
	local t = self.dir.x
	self.dir.x = -self.dir.y
	self.dir.y = t
end

function Snake:turnLeft()
	local t = self.dir.y
	self.dir.y = -self.dir.x
	self.dir.x = t
end