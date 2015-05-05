--[[
	OmniOS debug
	app
]]--
--Startup
local file = fs.open("OmniOS/Programs/Debug.app/startup.txt","r")
local data = file.readAll()
file.close()
local toOpen = {}
for token in data:gmatch("[^\n]+") do
    toOpen[#toOpen+1] = token
end
for i,v in pairs(toOpen) do
    System.newTask(v,v)
end


--[[
    Modified version of Shell
]]--
promptColour = colours.yellow
textColour = colours.white
bgColour = colours.black


local function run(command,...)
	if fs.exists("OmniOS/Programs/Debug.app/Commands/"..command..".lua") and not fs.isDir("OmniOS/Programs/Debug.app/Commands/"..command..".lua") then
		local func, err = loadfile("OmniOS/Programs/Debug.app/Commands/"..command..".lua")
        local overArgs = {...}
		setfenv(func,_G)
        if command == "kill" or command == "terminate" then
                func(firstArg,unpack(overArgs))
        else 
			local ok, data = pcall(func,unpack(overArgs))
            if not ok then log.log("Debug",data) end
		end
	else
		print("Command is non-existent! Pay more attention when writting!")
	end
end

local function tokenise( ... )
    local sLine = table.concat( { ... }, " " )
	local tWords = {}
    local bQuoted = false
    for match in string.gmatch( sLine .. "\"", "(.-)\"" ) do
        if bQuoted then
            table.insert( tWords, match )
        else
            for m in string.gmatch( match, "[^ \t]+" ) do
                table.insert( tWords, m )
            end
        end
        bQuoted = not bQuoted
    end
    return tWords
end

if not OmniOS or not type(OmniOS) == "table" then OmniOS = {} end
OmniOS.debug = {}

function OmniOS.debug.run( ... )
	local tWords = tokenise( ... )
	local sCommand = tWords[1]
	if sCommand then
		return run( sCommand, unpack( tWords, 2 ) )
	end
	return false
end

term.setBackgroundColor( bgColour )
term.setTextColour( promptColour )
print("OmniOS/Debug")
term.setTextColour( textColour )

-- Read commands and execute them
local tCommandHistory = {}
while true do
    term.setBackgroundColor( bgColour )
    term.setTextColour( promptColour )
    write("> ")
    term.setTextColour( textColour )

    local sLine = read( nil, tCommandHistory )
    table.insert( tCommandHistory, sLine )
    OmniOS.debug.run( sLine )
end