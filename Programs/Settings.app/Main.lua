--[[
	Settings app
	by Creator
	for TheOS
]]--

--variables--
local w,h = term.getSize()
local MainLayoutTable = {}
local path = "TheOS/Programs/Settings.app/Data/"

--functions--
local loadLayout = function(sPath)
	local func = loadfile(sPath)
	--dofile(sPath)
	return func()
end

local function changeColor(color)
	local f = fs.open("TheOS/Programs/Desktop.app/Data/Settings","r")
	local Settings = textutils.unserialize(f.readAll())
	print(f.readAll())
	f.close()
	Settings.bgColor = colors[color] or colors.green
	local f = fs.open("TheOS/Programs/Desktop.app/Data/Settings","w")
	f.write(textutils.serialize(Settings))
	f.close()
end

local function split(str,sep)
	local buffer = {}
	for token in str:gmatch(sep) do
		buffer[#buffer+1] = token
	end
	return buffer
end

--Code--
os.loadAPI("TheOS/API/Interact")
local gui = Interact.Initialize()

--Layouts--
local MainLayout = gui.Layout.new({xPos = 1,yPos = 1,xLength = w,yLength = h})
local DesktopLayout = gui.Layout.new({xPos = 1,yPos = 1,xLength = w,yLength = h})
local SecurityLayout = gui.Layout.new({xPos = 1,yPos = 1,xLength = w,yLength = h})

--MainLayout--
local MainLayoutTable = gui.loadObjects(loadLayout(path.."Layouts/Main.layout"))
gui.loadLayout(MainLayoutTable,MainLayout)
MainLayout:addBackgroundColor({color = colors.white})

--Desktop Layout--
local DesktopLayoutTable = gui.loadObjects(loadLayout(path.."Layouts/Desktop.layout"))
gui.loadLayout(DesktopLayoutTable,DesktopLayout)
DesktopLayout:addBackgroundColor({color = colors.white})

--SecurityLayout--
local SecurityLayoutTable = gui.loadObjects(loadLayout(path.."Layouts/Security.layout"))
gui.loadLayout(SecurityLayoutTable,SecurityLayout)
SecurityLayout:addBackgroundColor({color = colors.white})


while true do
	MainLayout:draw()
	local MainLayoutEvent = gui.eventHandler(MainLayout)
	if MainLayoutEvent[1] == "Button" then
		if MainLayoutEvent[2] == "Desktop" then
			local notClose = true
			while notClose do
				DesktopLayout:draw()
				DesktopLayoutEvent = gui.eventHandler(DesktopLayout)
				if DesktopLayoutEvent[1] == "Button" then
					if DesktopLayoutEvent[2] == "Done" then
						notClose = false
					else
						local buffer = split(DesktopLayoutEvent[2],"[^:]+")
						print(DesktopLayoutEvent[2])
						changeColor(buffer[2])
					end
				end
			end
		elseif MainLayoutEvent[2] == "Security" then
			local notClose = true
			while notClose do
				SecurityLayout:draw()
				SecurityLayoutEvent = gui.eventHandler(SecurityLayout)
				if SecurityLayoutEvent[1] == "TextBox" then
					if SecurityLayoutEvent[2] == "Password" then
						local newPass = SecurityLayout.TextBox.Password:read()
						local file = fs.open("TheOS/Settings/Users/Admin","w")
						file.write(Sha.sha256(newPass))
						file.close()
					end
				elseif SecurityLayoutEvent[1] == "Button" then
					if SecurityLayoutEvent[2] == "Done" then
						notClose = false
					end
				end
			end
		elseif MainLayoutEvent[2] == "Close" then
			break
		end
	end
end