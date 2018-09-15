meta = "412:4"

print(string.find(meta, ':'))
print(string.sub(meta, 1, string.find(meta, ':')-1)  )
print(string.sub(meta, string.find(meta, ':')+1) )