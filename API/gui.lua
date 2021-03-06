--[[
	GUI API in ComputerCraft
	by Creator
	Complete rewrite in OOP
]]--

--Button Class--

Button = {}

newButton = function(_name,_label,_xPos,_yPos,_xLength,_yLength,_fgColor,_bgColor,_returnValue)
	local self = {}
	setmetatable(self,{__index = Button})
	self.name = _name
	self.label = _label
	self.xPos = _xPos
	self.yPos = _yPos
	self.fgColor = _fgColor
	self.bgColor = _bgColor
	self.xLength = _xLength
	self.yLength = _yLength
	self.returnValue = _returnValue
	return self
end

Button.draw = function(self)
	--term.setBackgroundColor(self.bgColor)
	paintutils.drawFilledBox(self.xPos,self.yPos,self.xLength-1,self.yLength-1,self.bgColor)
	
end

--Variables--
--Functions--

function addKey(key,returnValue)
	keysMain[#keysMain+1] = {key,returnValue}
end

function resetKeys()
	keysMain = {}
end

local function localAddField(minX,minY,maxX,maxY,returnV)
	buttonsMain[#buttonsMain+1] = {minX,minY,minX+maxX-1,minY+maxY-1,returnV}
end

function addField(minX,minY,maxX,maxY,returnV)
	if not pcall(localAddField,minX,minY,maxX,maxY,returnV) then
		print([[
		Usage:
		As an argument pass a table structured like this:
		{
			xPos,
			yPos,
			wide,
			height,
			returnValue,
		}
		]])
	end
end

local function localDrawButton(xPos,yPos,wide,height,colorOfButton,inButtonXPosOfLabel,inButtonYPosOfLabel,label,textColor,returnValue)
	if colorOfButton ~= nil then
		paintutils.drawFilledBox(xPos,yPos,xPos+wide-1,yPos+height-1,colorOfButton)
	end
	term.setTextColor(textColor)
	term.setCursorPos(xPos+inButtonXPosOfLabel-1,yPos+inButtonYPosOfLabel-1)
	local textToPrint = string.sub(label,1,xPos+wide-inButtonXPosOfLabel)
	term.write(textToPrint)
	buttonsMain[#buttonsMain+1] = {xPos,yPos,xPos+wide-1,yPos+height-1,returnValue}
end

function drawButton(xPos,yPos,wide,height,colorOfButton,inButtonXPosOfLabel,inButtonYPosOfLabel,label,textColor,returnValue)
	if not pcall(localDrawButton,xPos,yPos,wide,height,colorOfButton,inButtonXPosOfLabel,inButtonYPosOfLabel,label,textColor,returnValue) then
		print([[
		Usage:
		As an argument pass a table structured like this:
		{
			xPos,
			yPos,
			wide,
			height,
			colorOfButton,
			inButtonXPosOfLabel,
			inButtonYPosOfLabel,
			label,
			textColor,
			returnValue,
		}
		You can have the option to not use the background color.
		You can do this by simply setting color of button to nil.
		]])
	end
end

function detectButtonOrKeyHit()
	while true do
		local event, button, x, y
		repeat
			event, button, x, y = os.pullEvent()
		until (event == "mouse_click" and buttonsMain ~= nil) or (event == "key" and keysMain ~= nil)
		if event == "mouse_click" then
			for i,v in pairs(buttonsMain) do
				if v[1] <= x and x <= v[3] and v[2] <= y and y <= v[4] then
					return {v[5], button, x, y}
				end
			end
		elseif event == "key" then
			for i,v in pairs(keysMain) do
				if button == v[1] then
					return {v[2]}
				end
			end
		end
	end
end

function resetButtons()
	buttonsMain = {}
end

local function localCPrint(txt,color,bgColor,xPos,yPos,maxL)
	if not maxL == nil then
		txt = string.sub(txt,1,maxL)
	end
	term.setTextColor(color)
	if bgColor ~= nil then
		term.setBackgroundColor(bgColor)
	end
	term.setCursorPos(xPos,yPos)
	term.write(txt)
end

function cPrint(txt,color,bgColor,xPos,yPos,maxL)
	if not pcall(localCPrint,txt,color,bgColor,xPos,yPos,maxL) then
		print([[
			Usage:
			Arguments are as follws:
			{
			Text to print
			Text color
			Background color
			xPos
			yPos
			Maximal lenght of the string
			}
			Maximal lenght of the string can be left "nil" with qoutes
		]])
	end
end