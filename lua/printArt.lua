local component = require("component")
local shell = require("shell")
local fs = require("filesystem")

local printer = component.printer3d
local args = shell.parse(...)

file = fs.open(args[1], "rb")
if not file then
  io.write("No file named " .. args[1])
end

local selection = args[3]
local i = 0
local j = 0

index = 1
n = file:read(1)
printer.setLabel(args[2])
printer.setLightLevel(15)
printer.setRedstoneEmitter(false)
printer.setButtonMode(false)

while n and n~='|' do
	meta += file.read(1)
end

i = tonumber(string.sub(meta, 0, string.find(meta, ':')))
j = tonumber(string.sub(meta, string.find(meta, ':')))
io.write("resolution: ".. i .. ":" .. j .. " blocks, totally " .. i*j .. "\n")

if selection ~= nill then
	if string.match(selection, "^\d+:\d+$") then
		xpos = tonumber(string.sub(selecion, 0, string.find(selection, ':')))
		ypos = tonumber(string.sub(selection, string.find(selection, string.find(meta, ':')))
		io.write("single print of block with position " .. xpos .. "+" .. ypos .. "\n")

		splitter_index = 0
		while n or splitter_index <= xpos*ypos do
			n = file:read(1)
			if n == '+' do
				splitter_index = spliter_index + 1
			end
		end


		while n and n~='+' do
			x = tonumber(n, 16)
			y = file:read(1)
			l = file:read(1)
			y = tonumber(y, 16)
			l = tonumber(l, 16)+1
			local result, reason = printer.addShape(x, y, 15, x+1, y+l, 16, "opencomputers:White", false, tonumber(file:read(6), 16))
			print("coords: "..x.. ":" ..y)

			if not result then
				io.write("Failed adding shape: " .. tostring(reason) .. "\n")
				io.write("Shapes count:" .. printer.getShapeCount() .. "from " .. printer.getMaxShapeCount() .. " allowed\n")
				break
			end
			n = file:read(1)
			printer.commit(1)
			n = file:read(1)
			print("part ".. i .. ":" .. j .." committed")
			io.read("*n")

		else
			io.write("Wrong selection argument! aborting. \n")
			return
		end
else --not closed~!

	while n do
		printer.reset()
		printer.setTooltip("part" .. index)

		file:read(1)




			while n and n~='+' do

			 -- n is the next char

			x = tonumber(n, 16)
			y = file:read(1)
			l = file:read(1)
			y = tonumber(y, 16)
			l = tonumber(l, 16)+1
			local result, reason = printer.addShape(x, y, 15, x+1, y+l, 16, "opencomputers:White", false, tonumber(file:read(6), 16))
			print("coords: "..x.. ":" ..y)

			if not result then
				io.write("Failed adding shape: " .. tostring(reason) .. "\n")
				io.write("Shapes count:" .. printer.getShapeCount() .. "from " .. printer.getMaxShapeCount() .. " allowed\n")
				break
			end
			n = file:read(1)
	end
	printer.commit(1)
	n = file:read(1)
	print("part ".. index .." committed")
	index = index + 1
	io.read("*n")
	end
end
io.write("We've got to the very end YAYAY")


