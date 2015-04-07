--Code--
local apis = fs.list("OmniOS/API/")
local dirs = {}
for i,v in pairs(apis) do
	if fs.isDir("OmniOS/API/"..v) then
		dirs[i] = true
	end
end
for i,v in pairs(dirs) do
	apis[i] = nil
end
for i,v in pairs(apis) do
	os.loadAPI("OmniOS/API/"..v)
	term.setTextColor(colors.black)
	print(v)
end
os.pullEvent()