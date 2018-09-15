local component = require("component")
local shell = require("shell")
local fs = require("filesystem")

local args = shell.parse(...)

local holo = component.hologram
holo.clear()

gold = 0xFFDF00
white = 0xFFFFFF
purple = 0x9933FF

hologram.setPaletteColor(1, purple)
hologram.setScale(3)

file = fs.open(args[1], "rb")
if not file then
  io.write("No file named " .. args[1])
end

index = 1
n = file:read(1)
while n do
  
  while n and n~='+' do
    -- n is the next char
    x = tonumber(n, 16)
	y = file:read(1)
	l = file:read(1)
	y = tonumber(y, 16)
	l = tonumber(l, 16)+1
	--local result, reason = printer.addShape(x, y, 15, x+1, y+l, 16, "opencomputers:White", false, tonumber(file:read(6), 16)) 
    holo.set(x, y, 15, tonumber(file:read(6), 16))  
   -- print("coords: "..x.. ":" ..y)
    
	n = file:read(1)
  end
  printer.commit(1)
  n = file:read(1)
end

