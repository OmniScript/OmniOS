--[[
	BIOS by Creator
	for TheOS
]]--

--Variables--
local gui = {}
local OS = {}
local currentOS = 1
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
	term.setCursorPos(8,5)
	term.write(OS[currentOS][1])
	for i = 1, #OS do
		term.setCursorPos(8,i+7)
		term.write(OS[i][1])
	end
end

local function loadOS()
	return dofile("TheOS/BIOS/List")
end

--Code
OS = loadOS()
gui.drawMain()
os.pullEvent()