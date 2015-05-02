local tArgs = {...}
if tArgs[1] == "launch" then
	if tArgs[2] and tArgs[3] then
		print("Fine")
		return System.newTaskMon(tArgs[2], tArgs[4] or tArgs[3],tArgs[3])
	elseif not tArgs[2] then
		print("You need a monitor!")
	else
		print("You need a program!")
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
	print("  launch")
	print("  list")
end