--Code--
local apis = fs.list("OmniOS/API/")
local dirs = {}
function loadAPI( _sPath )
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
for i,v in pairs(apis) do
	if fs.isDir("OmniOS/API/"..v) then
		dirs[i] = true
	end
end
for i,v in pairs(dirs) do
	apis[i] = nil
end
for i,v in pairs(apis) do
	loadAPI("OmniOS/API/"..v)
	term.setTextColor(colors.black)
	nPrint(v:match("[^%.]+"))
end