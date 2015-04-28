local tArgs = {...}
if tArgs[1] == "clear" then
	if tArgs[2] == "!all" then
		fs.delete("OmniOS/Logs")
	elseif fs.exists("OmniOS/Logs/"..tArgs[2]) then
		tArgs[2] = tArgs[2]:gsub("%.%.","")
		fs.delete("OmniOS/Logs/"..tArgs[2])
	end
end