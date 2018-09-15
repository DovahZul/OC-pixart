
local component = require("component")
local shell = require("shell")
local fs = require("filesystem")

local printer = component.printer3d
local args = shell.parse(...)

file = fs.open(args[1], "rb")
printer.reset();
for i=0,16 do
    for j=0,16 do
        printer.addShape(i, j, 15, i+1, j+1, 16, "opencomputers:White", false, 0xff4d4d)
    end
end
printer.commit(1)



        local result, reason = printer.addShape(i, j, 15, i+1, j+1, 16, "opencomputers:White", false, 0xff4d4d)
  if not result then
    io.write("Failed adding shape: " .. tostring(reason) .. "\n")
  end
printer.commit(1)