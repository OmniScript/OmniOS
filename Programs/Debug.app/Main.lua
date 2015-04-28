--[[
	OmniOS debug
	app
]]--
System.newTask("FileX","FileX")


--[[
    Modified version of Shell
]]--

promptColour = colours.yellow
textColour = colours.white
bgColour = colours.black

local function run(command,...)
	if fs.exists("OmniOS/Programs/Debug.app/Commands/"..command..".lua") and not fs.isDir("OmniOS/Programs/Debug.app/Commands/"..command..".lua") then
		local func, err = loadfile("OmniOS/Programs/Debug.app/Commands/"..command..".lua")
		setfenv(func,_G)
		if ... then 
			func(unpack({...}))
		else
			func()
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

if not OmniOS then OmniOS = {} end
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
    local data = {OmniOS.debug.run( sLine )}
    for i,v in pairs(data) do
        print(v)
    end
end