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

stone
