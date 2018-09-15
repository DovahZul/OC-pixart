meta = "412:4"

print(string.find(meta, ':'))
print(string.sub(meta, 1, string.find(meta, ':')-1)  )
print(string.sub(meta, string.find(meta, ':')+1) )

[[
io.write("Continue: Y/n")
evt, key = os.pullEvent()

if evt == "char" and key == somekey then
	io.write("Aborting.")
	return
elseif evt =="key" and key == keys.enter then
  --	break
end
]]