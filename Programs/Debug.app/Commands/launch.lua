local tArgs = {...}

if tArgs[1] then
	 if not System.newTask(tArgs[2] or tArgs[1],tArgs[1]) then
	 	print("The program does not exist or it contains an error!")
	 end
else
	print("You have to specify a program!")
end