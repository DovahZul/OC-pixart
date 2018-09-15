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
while n do
	printer.reset()
	printer.setLabel(args[2])
	printer.setTooltip("part" .. index)
	printer.setLightLevel(15)
	printer.setRedstoneEmitter(false)
	printer.setButtonMode(false)

		while n and n~='|' do
			meta += file.read(1)
		end
			i = tonumber(string.sub(meta, 0, meta.find(':')))
			j = tonumber(strung.sub(meta, meta.find(':'))
			io.write("resolution: ".. i .. ":" .. j .. " blocks, totally " .. i*j .. "\n")
			file:read(1)

		if selection ~= nill then
			if string.match(selection, "") then
				io.write("single print of block with position " .. i .. "+" .. j .. "\n")

			-------
			else
				io.write("Wrong selection argument! aborting. \n")
				return
			end

		else

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


