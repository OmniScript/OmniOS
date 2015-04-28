--[[
	System API
	for 
	TheOS
	by Creator
]]--

function reboot()
	os.reboot()
end

function newTask(name,title,...)
	log.log("System","Opening app "..name)
	local mainPath = "OmniOS/Programs/"..name..".app/Main.lua"
	local permissionPath = "OmniOS/Programs/"..name..".app/permission.data"
	if fs.exists(mainPath)  and not fs.isDir(mainPath) then
		local file = fs.open(permissionPath,"r")
		local permission = file.readAll and file.readAll() or "user"
		file.close()
		log.log("System","Opening app "..name..": retrieved permissions.")
		local func, err = loadfile(mainPath)
		if func then
			log.log("System","Opening app "..name..": about to launch task.")
			if Kernel.newRoutine then
				Kernel.newRoutine(name,title,func,permission,...)
			else
				return false
			end
			log.log("System","Opening app "..name..": launched task.")
		end
		return true
	end
	return false
end

function newTaskMon(side,name,title,...)
	log.log("System","Opening app "..name)
	local mainPath = "OmniOS/Programs/"..name..".app/Main.lua"
	local permissionPath = "OmniOS/Programs/"..name..".app/permission.data"
	if fs.exists(mainPath)  and not fs.isDir(mainPath) then
		local file = fs.open(permissionPath,"r")
		local permission = file.readAll and file.readAll() or "user"
		file.close()
		log.log("System","Opening app "..name..": retrieved permissions.")
		local func, err = loadfile(mainPath)
		if func then
			log.log("System","Opening app "..name..": about to launch task.")
			if Kernel.newRoutineMon then
				Kernel.newRoutineMon(side,name,title,func,permission,...)
				log.log("System","Opening app on monitor "..side.." "..name..": launched task.")
			else
				return false
			end
			return unpack(data)
		end
		return true
	end
	return false
end

function getPerimssion(program)
	return getPerimssion(program)
end