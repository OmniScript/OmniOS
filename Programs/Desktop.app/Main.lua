--[[
	Desktop in ComputerCraft
	by Creator
	for OmniOS
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
local paths = {}
local scroll = 0
local programPath = "Data/"
OmniOS.loadAPI("NewInteract")

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


local function loadGUI()
	--Initializing GUI components
	gui = NewInteract.Initialize()
	mainLayout = gui.Layout.new(dofile(programPath.."Layouts/Main.layout"))
	quickSettingsLayout = gui.Layout.new(dofile(programPath.."Layouts/QuickSettings.layout"))
end

local function changeColor(color)
	Settings.bgColor = colors[color] or colors.green
	local f = fs.open(programPath.."Settings","w")
	f.write(textutilsserialize(Settings))
	f.close()
	local buffer = readFile(programPath.."Settings")
	Settings = textutils.unserialize( buffer )
	local buffer = readFile(programPath.."MatchingColors")
	MatchingColors = textutilsunserialize(buffer)
	loadObjects()
	InitializeGUI()
end

loadGUI()
InitializeGUI()


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
						notClose = false
					elseif answer[2] == "Refresh" then
						local buffer = readFile(programPath.."Settings")
						Settings = textutils.unserialize( buffer )
						local buffer = readFile(programPath.."MatchingColors")
						MatchingColors = textutilsunserialize(buffer)
						loadObjects()
						InitializeGUI()
						notClose = false
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
			System.newTask(result[2],result[2])
		end
	end
end