--! Event Class


Event = Object:extend()

function Event:new(t,m)
	self.type = t
	self.message = m
end