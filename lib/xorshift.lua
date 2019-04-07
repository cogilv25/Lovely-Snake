-- Written by Calum Lindsay
-- It is a pseudo-random number generator. There are 
-- probably issues but it suits my purposes.
--
-- It is a slightly modified version of
-- the xorshift* implementation from wikipedia:
--
-- https://en.wikipedia.org/wiki/Xorshift

local XOrShiftGenerator = {}
XOrShiftGenerator.__index = XOrShiftGenerator

function XOrShiftGenerator:new(seed)
	--Use supplied seed or static 32 bit value
	self.seed = seed or 1976839131
	self.state = self.seed
	self:initialise()
end

function XOrShiftGenerator:initialise()
	local n = (self:next()%20) + 3
	for i=0,n do
		self:next()
	end
end

function XOrShiftGenerator:next()
	local a = bit.lshift(self.state,13)
	local b = bit.rshift(self.state,17)
	local c = bit.lshift(self.state,5)
	self.state = bit.bxor(self.state,a)
	self.state = bit.bxor(self.state,b)
	self.state = bit.bxor(self.state,c)
	return self.state * 104053
end


function XOrShiftGenerator:__call(...)
  local newRNG = setmetatable({}, self)
  newRNG:new(...)
  return newRNG
end

setmetatable(XOrShiftGenerator,XOrShiftGenerator)
XOrShiftGenerator:new()
return XOrShiftGenerator