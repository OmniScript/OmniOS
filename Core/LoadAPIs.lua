--Code--
local apis = fs.list("TheOS/API/")
local dirs = {}
for i,v in pairs(apis) do
	if fs.isDir("TheOS/API/"..v) then
		dirs[i] = true
	end
end
for i,v in pairs(dirs) do
	apis[i] = nil
end
for i,v in pairs(apis) do
	os.loadAPI("TheOS/API/"..v)
	term.setTextColor(colors.black)
	print(v)
end
os.pullEvent()