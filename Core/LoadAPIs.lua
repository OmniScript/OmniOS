--Code--
local apis = fs.list("TheOS/API/")
for i,v in pairs(apis) do
	if fs.isDir("TheOS/API/"..v) then
		apis[i] = nil
	end
end
for i,v in pairs(apis) do
	os.loadAPI("TheOS/API/"..v)
	print(v)
end
sleep(10)