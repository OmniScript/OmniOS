--[[
	Desktop in ComputerCraft
	by Creator
	for TheOS
]]--
--Variables--
local textutilsserialize = textutils.serialize
local textutilsunserialize = textutils.unserialize
local w,h = term.getSize()
local Settings = {}
local result = {}
local Main = {}
local QuickSettings = {}
local MatchingColors = {}
local gui = {}
local mainLayout = {}
local quickSettingsLayout = {}
local mainLayoutTable = {}
local quickSettingsLayoutTable = {}
local paths = {}
local scroll = 0

--Functions--
local function readFile(_path)
	local file = fs.open(_path,"r")
	local data = file.readAll()
	file.close()
	return data
end

local function split(str,sep)
	local buffer = {}
	for token in str:gmatch(sep) do
		buffer[#buffer+1] = token
	end
	return buffer
end

function loadShortcut()
	local file = fs.open("TheOS/Programs/Desktop.app/Data/Shortcuts","r")
	local buffer = file.readAll()
	file.close()
	
	local sBuffer = textutils.unserialize(buffer)
	local nBuffer = {}
	paths = {}
	for i,v in pairs(sBuffer) do
		nBuffer[v.name] = {
			xPos = 2+(6*(v.xPos-1)),
			yPos = 1+(5*(v.yPos-1)),
			name = v.name,
			path = v.path..".ico",
			yLength = 4,
			xLength = 3,
			returnValue = v.name,
			label = v.name,
			labelFg = MatchingColors[Settings.bgColor]["mainButtons"],
			labelBg = Settings.bgColor,
			moveY = true,
		}
		paths[v.name] = v.path
	end
	Main.BetterPaint = nBuffer
end

function initializeGUI()
	local funcTable = {
		w = w,
		h = h,
		Settings = Settings,
		MatchingColors = MatchingColors,
	}
	local func = loadstring(readFile("TheOS/Programs/Desktop.app/Data/Layouts/Main.layout"))
	setfenv(func,funcTable)
end

local function changeColor(color)
	Settings.bgColor = colors[color] or colors.green
	local f = fs.open("TheOS/Programs/Desktop.app/Data/Settings","w")
	f.write(textutilsserialize(Settings))
	f.close()
	local buffer = readFile("TheOS/Programs/Desktop.app/Data/Settings")
	Settings = textutils.unserialize( buffer )
	local buffer = readFile("TheOS/Desktop/MatchingColors")
	MatchingColors = textutilsunserialize(buffer)
end

--Loading settings--
local buffer = readFile("TheOS/Programs/Desktop.app/Data/Settings")
Settings = textutils.unserialize( buffer )

local buffer = readFile("TheOS/Programs/Desktop.app/Data/MatchingColors")
MatchingColors = textutilsunserialize(buffer)


--Code--
while true do
	mainLayout:draw(0,scroll)
	local result = gui.eventHandler(mainLayout)
	if result[1] == "Button" then
		if result[2] == "quickSettings" then
			quickSettingsLayout:draw()
			local notClose = true
			while notClose do
				local answer = gui.eventHandler(quickSettingsLayout)
				if answer[1] == "Button" then
					if answer[2] == "reboot" then
						os.reboot()
					elseif answer[2] == "shutdown" then
						os.shutdown()
					elseif answer[2] == "Close" then
						notClose = false
					elseif answer[2] == "settings" then
						System.newTask("Settings","Settings")
					else
						local buffer = split(answer[2],"[^:]+")
						changeColor(buffer[2])
						notClose = false
					end
				elseif answer[1] == "Nil" then
					if answer[2] == "Nil" then
						notClose = false
					end
				end
			end
		elseif result[2] == "windowPlus" then
			scroll = scroll - 51
		elseif result[2] == "windowMinus" then
			scroll = scroll + 51
		else
			print(result[2])
			os.pullEvent()
			System.newTask(result[2],result[2])
		end
	end
end