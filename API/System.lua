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
	local file = fs.open(permissionPath,"r")
	local permission = file.readAll and file.readAll() or "user"
	file.close()
	log.log("System","Opening app "..name..": retrieved permissions.")
	if fs.exists(mainPath) then
		local func, err = loadfile(mainPath)
		if func then
			log.log("System","Opening app "..name..": about to launch task.")
			if newRoutine then
				newRoutine(name,title,func,permission,...)
			else
				return func
			end
			log.log("System","Opening app "..name..": launched task.")
		end
	end
	return false
end

function getPerimssion(program)
	return getPerimssion(program)
end