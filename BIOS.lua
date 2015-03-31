--[[
	BIOS by Creator
	for TheOS
]]--

--Variables--
local gui = {}
local OS = {}
local timeLeft = 5
local currentOS = 1
local defaultOS = ""
local toBoot = 0
local layout = [[
     +-----------------------------------------+
     | Current selection:                      |
     |                                         |
     +-----------------------------------------+
     | Available OSes:                         |
     |                                         |
     |                                         |
     |                                         |
     |                                         |
     |                                         |
     |                                         |
     +-----------------------------------------+
     | S: Settings                             |
     +-----------------------------------------+
     | Time left:                              |
     +-----------------------------------------+
]]
--Functions
function gui.clear()
	term.setBackgroundColor(colors.blue)
	term.setTextColor(colors.white)
	term.setCursorPos(1,2)
	term.clear()
end

function gui.drawMain(tOS)
	gui.clear()
	term.setCursorPos(1,3)
	print(layout)
	term.setCursorPos(8,4)
	term.write(OS[currentOS][1])
	for i = 1, #OS do
		term.setCursorPos(8,i+6)
		term.write(OS[i][1])
	end
	term.setCursorPos(19,16)
	term.write(timeLeft)
end

local function loadOS()
	return dofile("TheOS/BIOS/List")
end

local function loadDefault()
	return dofile("TheOS/BIOS/default")
end

local function findCurrent()
	for i, v in pairs(OS) do
		if defaultOS == v[1] then
			return i
		end
	end
	error("The OS you are searching does not exist!")
end

--Code
OS = loadOS()
defaultOS = loadDefault()
currentOS = findCurrent()
while true do 
	gui.drawMain()
	local event = {os.pullEvent("char")}
	print(event[1])
	print(event[2])
	if tonumber(event[2]) then
		print("cow")
		if OS[tonumber(event[2])] then
			print"hell"
			toBoot = tonumber(event[2])
			break
		end
	else

	end
	os.pullEvent("mouse_click")
end

dofile(OS[toBoot][2])