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
local programPath = "TheOS/Programs/Desktop.app/Data/"

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

local function loadShortcuts()
	local buffer = readFile(programPath.."Shortcuts")
	local sBuffer = textutilsunserialize(buffer)
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

local function loadObjects()
--Object table--
	Main.Button = {
	quickSettings = {
		name = "quickSettings",
		label = "^",
		xPos = 1,
		yPos = h,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = MatchingColors[Settings.bgColor]["mainButtons"],
		bgColor = Settings.bgColor,
		returnValue = "quickSettings",
	},
	windowPlus = {
		name = "windowPlus",
		label = ">",
		xPos = w,
		yPos = 1,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = MatchingColors[Settings.bgColor]["mainButtons"],
		bgColor = Settings.bgColor,
		returnValue = "windowPlus",
	},
	windowMinus = {
		name = "windowMinus",
		label = "<",
		xPos = 1,
		yPos = 1,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = MatchingColors[Settings.bgColor]["mainButtons"],
		bgColor = Settings.bgColor,
		returnValue = "windowMinus",
	},
}

	QuickSettings.Button = {
	Close = {
		name = "Close",
		label = "x",
		xPos = w,
		yPos = 1,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = Settings.bgColor,
		bgColor = MatchingColors[Settings.bgColor]["mainButtons"],
		returnValue = "Close",
	},
	Right = {
		name = "Right",
		label = ">",
		xPos = w-1,
		yPos = 5,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = MatchingColors[Settings.bgColor]["mainButtons"],
		bgColor = MatchingColors[Settings.bgColor]["quickSettings"],
		returnValue = "Right",
	},
	Left = {
		name = "Left",
		label = "<",
		xPos = 2,
		yPos = 5,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = MatchingColors[Settings.bgColor]["mainButtons"],
		bgColor = MatchingColors[Settings.bgColor]["quickSettings"],
		returnValue = "Left",
	},
	Green = {
		name = "Green",
		label = " ",
		xPos = 31,
		yPos = 6,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.green,
		returnValue = "color:green",
	},
	Lime = {
		name = "Lime",
		label = " ",
		xPos = 31,
		yPos = 7,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.lime,
		returnValue = "color:lime",
	},
	Brown = {
		name = "Brown",
		label = " ",
		xPos = 32,
		yPos = 6,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.brown,
		returnValue = "color:brown",
	},
	Purple = {
		name = "Purple",
		label = " ",
		xPos = 32,
		yPos = 7,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.purple,
		returnValue = "color:purple",
	},
	Blue = {
		name = "Blue",
		label = " ",
		xPos = 33,
		yPos = 6,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.blue,
		returnValue = "color:blue",
	},
	lightBlue = {
		name = "lightBlue",
		label = " ",
		xPos = 33,
		yPos = 7,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.lightBlue,
		returnValue = "color:lightBlue",
	},
	Yellow = {
		name = "Yellow",
		label = " ",
		xPos = 34,
		yPos = 6,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.yellow,
		returnValue = "color:yellow",
	},
	Cyan = {
		name = "Cyan",
		label = " ",
		xPos = 34,
		yPos = 7,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.cyan,
		returnValue = "color:cyan",
	},
	Orange = {
		name = "Orange",
		label = " ",
		xPos = 35,
		yPos = 6,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.orange,
		returnValue = "color:orange",
	},
	Pink = {
		name = "Pink",
		label = " ",
		xPos = 35,
		yPos = 7,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.pink,
		returnValue = "color:pink",
	},
	Red = {
		name = "Red",
		label = " ",
		xPos = 36,
		yPos = 6,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.red,
		returnValue = "color:red",
	},
	Magenta = {
		name = "Magenta",
		label = " ",
		xPos = 36,
		yPos = 7,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.magenta,
		returnValue = "color:magenta",
	},
	White = {
		name = "White",
		label = " ",
		xPos = 37,
		yPos = 6,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.white,
		returnValue = "color:white",
	},
	lightGray = {
		name = "lightGray",
		label = " ",
		xPos = 37,
		yPos = 7,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.lightGray,
		returnValue = "color:lightGray",
	},
	Black = {
		name = "Black",
		label = " ",
		xPos = 38,
		yPos = 6,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.black,
		returnValue = "color:black",
	},
	Gray = {
		name = "Gray",
		label = " ",
		xPos = 38,
		yPos = 7,
		xLength = 1,
		yLength = 1,
		xTextPos = 1,
		yTextPos = 1,
		fgColor = 1,
		bgColor = colors.gray,
		returnValue = "color:gray",
	},
}

	QuickSettings.ColorField = {
	TopBar = {
		name = "TopBar",
		xPos = 1,
		yPos = 1,
		xLength = w,
		yLength = 1,
		color = MatchingColors[Settings.bgColor]["mainButtons"],
	},
}

	QuickSettings.BetterPaint = {
	Restart = {
		xPos = 4,
		yPos = 2,
		name = "Restart",
		path = programPath.."QuickSettings/restart.ico",
		yLength = 5,
		xLength = 7,
		returnValue = "reboot",
		label = "Restart",
		labelFg = colors.white,
		labelBg = MatchingColors[Settings.bgColor]["quickSettings"],
	},
	Shutdown = {
		xPos = 22,
		yPos = 2,
		name = "Shutdown",
		path = programPath.."QuickSettings/shutdown.ico",
		yLength = 5,
		xLength = 7,
		returnValue = "shutdown",
		label = "Shutdown",
		labelFg = colors.white,
		labelBg = MatchingColors[Settings.bgColor]["quickSettings"],
	},
	Settings = {
		xPos = 13,
		yPos = 2,
		name = "Settings",
		path = programPath.."QuickSettings/settings.ico",
		yLength = 5,
		xLength = 7,
		returnValue = "settings",
		label = "Settings",
		labelFg = colors.white,
		labelBg = MatchingColors[Settings.bgColor]["quickSettings"],
	},
}

	QuickSettings.Text = {
	Label = {
		name = "Label",
		text = "QuickSettings",
		xPos = w/2-6,
		yPos = 1,
		bgColor = MatchingColors[Settings.bgColor]["mainButtons"],
		fgColor = Settings.bgColor,
	},
}

	loadShortcuts()

end

local function loadGUI()
	--Initializing GUI components
	gui = Interact.Initialize()
	mainLayout = gui.Layout.new({xPos = 1,yPos = 1,xLength = w,yLength = h})
	quickSettingsLayout = gui.Layout.new({xPos = 1,yPos = h-7,xLength = w,yLength = h, nilClick = true})
	mainLayoutTable = {}
	quickSettingsLayoutTable = {}
end

local function InitializeGUI()
	loadObjects()
	--Main--
	mainLayoutTable = {}
	mainLayoutTable = gui.loadObjects(Main)
	mainLayoutTable.mainBgColor = gui.BackgroundColor.new({color = Settings.bgColor})
	
	--QuickSettings--
	quickSettingsLayoutTable = {}
	quickSettingsLayoutTable.Text = {}
	quickSettingsLayoutTable = gui.loadObjects(QuickSettings)
	quickSettingsLayoutTable.quickSettingsBgColor = gui.BackgroundColor.new({color = MatchingColors[Settings.bgColor]["quickSettings"]})
	--quickSettingsLayoutTable.Text.Test = gui.Text.new(QuickSettings.Text.Test)
	
	--Initializing structures--
	--Main--
	for i,v in pairs(mainLayoutTable.Button) do
		mainLayout:addButton(mainLayoutTable.Button[i]:returnData())
	end
	for i,v in pairs(mainLayoutTable.BetterPaint) do
		mainLayout:addBetterPaint(mainLayoutTable.BetterPaint[i]:returnData())
	end
	mainLayout:addBackgroundColor(mainLayoutTable.mainBgColor:returnData())
	
	--QuickSettings--
	for i,v in pairs(quickSettingsLayoutTable.Button) do
		quickSettingsLayout:addButton(quickSettingsLayoutTable.Button[i]:returnData())
	end
	quickSettingsLayout:addBackgroundColor(quickSettingsLayoutTable.quickSettingsBgColor:returnData())
	quickSettingsLayout:addColorField(quickSettingsLayoutTable.ColorField.TopBar:returnData())
	quickSettingsLayout:addBetterPaint(quickSettingsLayoutTable.BetterPaint.Restart:returnData())
	quickSettingsLayout:addBetterPaint(quickSettingsLayoutTable.BetterPaint.Shutdown:returnData())
	quickSettingsLayout:addBetterPaint(quickSettingsLayoutTable.BetterPaint.Settings:returnData())
	quickSettingsLayout:addText(quickSettingsLayoutTable.Text.Label:returnData())
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

local function writeTable()
	file = fs.open(programPath.."MatchingColorsLKK","w")
	file.write(textutilsserialize({
		[8192] = {
			name = "green",
			quickSettings = colors.lime,
		},
	}))
	--for i,v in pairs (colors) do
	--	file.write(tostring(i).." "..tostring(v).."\n")
	--end
	file.close()
end


--Loading settings--
local buffer = readFile(programPath.."Settings")
Settings = textutils.unserialize( buffer )

local buffer = readFile(programPath.."MatchingColors")
MatchingColors = textutilsunserialize(buffer)



loadObjects()
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