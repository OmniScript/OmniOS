local tArgs = {...}
if tArgs[1] == "!zygote" then
	error("Zygote killed!")
elseif tArgs[1] == "!all" then
	for i,v in pairs(Kernel.list()) do
		Kernel.kill(v)
	end
else
	if tonumber(tArgs[1]:sub(-1,-1)) then
		local resp = Kernel.kill(tArgs[1])
		if resp then
			print(resp)
		end
	else
		print("The routines have a number at the end. Don't forget it!")
	end
end