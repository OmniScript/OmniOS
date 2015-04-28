local tArgs = {...}
if tArgs[1] == "launch" then
	return System.newTaskMon(tArgs[2], tArgs[4] or tArgs[3],tArgs[3])
end 