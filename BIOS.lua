--[[
	BIOS by Creator
	for OmniOS
]]--

term.redirect(term.native())

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

function gui.drawMain()
	gui.clear()
	term.setCursorPos(1,3)
	print(layout)
	term.setCursorPos(8,4)
	term.write(OS[currentOS][1])
	for i = 1, #OS do
		term.setCursorPos(8,i+6)
		term.write(i..") "..OS[i][1])
	end
	term.setCursorPos(19,16)
	term.write(timeLeft)
end

local function loadOS()
	return dofile("OmniOS/BIOS/List")
end

local function loadDefault()
	return dofile("OmniOS/BIOS/default")
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
	local timerID = os.startTimer(1)
	local event = {os.pullEvent()}
	if timeLeft == 0 then
		toBoot = currentOS
		break
	end
	if event[1] == "key" then
		os.cancelTimer(timerID)
		if 2 <= event[2] and event[2] <= 11 then
			event[2] = event[2] == 11 and 0 or event[2] - 1
			if OS[event[2]] then
				toBoot = event[2]
				break
			end
		elseif event[2] == keys.up then
			currentOS = currentOS - 1
			currentOS = currentOS == 0 and #OS or currentOS
		elseif event[2] == keys.down then
			currentOS = currentOS + 1
			currentOS = currentOS == #OS + 1 and 1 or currentOS
		elseif event[2] == keys.enter then
			toBoot = currentOS
			break
		end
	elseif event[1] == "timer" and event[2] == timerID then
		timeLeft = timeLeft - 1
	end
end

if OS[toBoot][1] == "CraftOS" then
	term.setBackgroundColor(colors.black)
	term.setTextColor(colors.yellow)
	term.clear()
	term.setCursorPos(1,1)
	print("CraftOS 1.7")
else
	dofile(OS[toBoot][2])
end