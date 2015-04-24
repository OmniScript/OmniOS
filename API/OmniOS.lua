version = "alpha"
tag = "15w16a"
loadAPI = function(_sPath)
	_sPath = fs.exists("OmniOS/API/".._sPath) and "OmniOS/API/".._sPath or "OmniOS/lib/".._sPath
	local sName = fs.getName( _sPath )
	local tEnv = {}
	setmetatable( tEnv, { __index = _G } )
	local fnAPI, err = loadfile( _sPath )
	if fnAPI then
		setfenv( fnAPI, tEnv )
		local ok, err = pcall( fnAPI )
		if not ok then
			printError( err )
			return false
		end
	else
		printError( err )
		return false
	end
	
	local tAPI = {}
	for k,v in pairs( tEnv ) do
		tAPI[k] =  v
	end
	
	_G[sName:match("[^%.]+")] = tAPI	
	return true
end

requireAPI = function(_sPath)
	local sName = fs.getName( _sPath )
	local tEnv = {}
	setmetatable( tEnv, { __index = _G } )
	local fnAPI, err = loadfile( _sPath )
	if fnAPI then
		setfenv( fnAPI, tEnv )
		local ok, err = pcall( fnAPI )
		if not ok then
			printError( err )
			return false
		end
	else
		printError( err )
		return false
	end
	
	local tAPI = {}
	for k,v in pairs( tEnv ) do
		tAPI[k] =  v
	end
	return tAPI	
end
function getFile(path)
	if fs.exists(path) and not fs. isDir(path) then
		local file = fs.open(path,"r")
		local data = file.readAll()
		file.close()
		return data
	end
	return false
end
FS = fs