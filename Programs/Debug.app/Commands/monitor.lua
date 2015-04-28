local tArgs = {...}
if tArgs[1] == "launch" then
	if tArgs[2] and tArgs[3] then
		return System.newTaskMon(tArgs[2], tArgs[4] or tArgs[3],tArgs[3])
	else
		if not tArgs[2] then
			return "You need a monitor!"
		elseif not tArgs[3] then
			return "You need a program!"
		end
	end
elseif tArgs[1] == "list" then
	print("The available monitors are:")
	for i,v in pairs(peripheral.getNames()) do
		if peripheral.getType(v) == "monitor" then
			print(" "..v)
		end
	end
else
	print("The available monitor functions are:")
	print("launch")
end