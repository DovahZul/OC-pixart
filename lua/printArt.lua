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

local xmax = 0
local ymax = 0
local xpos = 0
local ypos = 0

index = 1
n = file:read(1)
printer.setLabel(args[2])
printer.setLightLevel(15)
printer.setRedstoneEmitter(false)
printer.setButtonMode(false)

--reading aspect ratio of an image in its parts with predetermined size (look up in Printer.java)
meta = ""
while n and n~='|' do
	meta = meta .. tostring(n)
	n = file:read(1)
end
io.write("AFTER meta current n = " .. n .. "\n")
--io.write("meta: " .. meta .. "\n")
xmax = tonumber(string.sub(meta, 1, string.find(meta, ':')-1) )
ymax = tonumber(string.sub(meta, string.find(meta, ':')+1) )

io.write("resolution: ".. xmax .. ":" .. ymax .. " blocks, totally " .. xmax*ymax .. "\n")

--getting coords of target block to print
if selection ~= nill then
	if string.match(selection, "%d+:%d+") then
		xpos = tonumber(string.sub(selection, 0, string.find(selection, ':')))
		ypos = tonumber(string.sub(selection, string.find(selection, string.find(meta, ':'))))
		io.write("single print of block with position " .. xpos .. "+" .. ypos .. "\n")

		--goint to needed separator ( too ungainly perhaps, got to fix it in time.. )
		separator_index = 0
		while n or separator_index <= xpos*ypos do
			n = file:read(1)
			if n == '+' then
				separator_index = separator_index + 1
			end
		end

		--print target block
		printer.reset()
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
				io.write("Failed adding shape, reason:" .. tostring(reason) .. "\n")
				io.write("Shapes count:" .. printer.getShapeCount() .. "from " .. printer.getMaxShapeCount() .. " allowed" .. "\n")
				return
			end
		end
			n = file:read(1)
			printer.commit(1)
			n = file:read(1)
			print("part ".. xpos .. ":" .. ypos .." committed")
			--io.read("*n")

		else
			io.write("Wrong selection argument! aborting. \n")
			return
		end
else
	--print whole image
	n = file:read(1)
	while n do
		printer.reset()
		printer.setTooltip("part" .. index)

		io.write("Processing..." .. "\n")
		while n and n~='+' do

			-- n is the next char

			x = tonumber(n, 16)
			y = file:read(1)
			l = file:read(1)
			y = tonumber(y, 16)
			l = tonumber(l, 16)+1
			result = printer.addShape(x, y, 15, x+1, y+l, 16, "opencomputers:White", false, tonumber(file:read(6), 16))
			n = file:read(1)

			if not result then

				io.write("Failed adding shape: " .. tostring(reason) .. "\n")
				io.write("Shapes count:" .. printer.getShapeCount() .. "from " .. printer.getMaxShapeCount() .. " allowed\n")
				return
			end
		end
		printer.commit(1)
		n = file:read(1)
		print("part ".. index .." committed")
		index = index + 1

		status, ready = printer.status()
		io.write("waiting for printer..." .. "\n")
		while status ~= "idle" and ready ~=true do
			os.sleep(1)
			status, ready = printer.status()
		end

	end
end
io.write("We've got to the very end YAYAY")

