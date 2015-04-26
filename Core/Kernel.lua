--[[
	TheOS Kernel
	by Creator
	for OmniOS &
	you to learn
	from it! (Yeah learn, rather become dumber)
	theoriginalbit
	also gets credit for 
	his safePairs function.
	Lots of thanks to BombBloke too for 
	finalizing and bug fixing it.
]]--

local logMessage = ""
local history = {}
local w,h = term.getSize()
local currTerm, routines, activeRoutine, eventBuffer = term.current(), {}, "", {}
local eventFilter = {["key"] = true, ["mouse_click"] = true, ["monitor_touch"] = true, ["paste"] = true,
	["char"] = true, ["terminate"] = true, ["mouse_scroll"] = true, ["mouse_drag"] = true}

local function safePairs(t)
  local keys = {}
  for k,v in pairs(t) do
	keys[#keys+1] = k
  end
  local i = 0
  return function()
	i = i + 1
	return keys[i], t[keys[i]] 
  end
end

local function drawClosed()
	paintutils.drawLine(w,1,w,h,colors.black)
	term.setTextColor(colors.white)
	term.setBackgroundColor(colors.black)
	term.setCursorPos(w,h/2+2)
	term.write("<")
end

local function drawOpen()
	term.setCursorBlink(false)
	paintutils.drawFilledBox(w-15,1,w,h,colors.black)
	local xVsProcess, curr = {}, 1
	term.setTextColor(colors.white)
	for i,v in pairs(routines) do
		paintutils.drawLine(w-15,curr*2,w,curr*2,i == activeRoutine and colours.blue or colours.black)
		paintutils.drawLine(w-15,curr*2+1,w,curr*2+1,i == activeRoutine and colours.blue or colours.black)
		term.setBackgroundColour(i == activeRoutine and colours.blue or colours.black)
		term.setCursorPos(w-14,curr*2)
		term.write("x "..v.title)
		term.setCursorPos(w-12,curr*2+1)
		term.write(coroutine.status(v.routine))
		xVsProcess[curr*2] = i
		curr = curr + 1
	end
	--print(activeRoutine)
	--for i,v in pairs(history) do
	--	print(i.." "..v)
	--end

	while true do
		local evnt = {os.pullEventRaw()}
		log.log("Close",xVsProcess[evnt[4]])
		if evnt[1] == "mouse_click" then
			if w-12 <= evnt[3] and evnt[3] <= w then
				if xVsProcess[evnt[4]] then
					routines[activeRoutine].window.setVisible( false )
					activeRoutine = xVsProcess[evnt[4]]
					routines[activeRoutine].window.setVisible(true)
					--history[#history+1] = activeRoutine
					return
				end
			elseif w-14 == evnt[3] then
				if xVsProcess[evnt[4]] and xVsProcess[evnt[4]] ~= "Debug1" then
					if activeRoutine == xVsProcess[evnt[4]] then
						--history[#history] = nil
						--for i,v in pairs(history) do
						--	if xVsProcess[evnt[4]] == v then
						--		table.remove(history,i)
						--	end
						--activeRoutine = history[#history]
						activeRoutine = "Debug1"
						routines[activeRoutine].window.setVisible(true)
					end
					routines[xVsProcess[evnt[4]]] = nil
					return
				end
			else return end
		else eventBuffer[#eventBuffer+1] = evnt end
	end
end

local function checkIfDead(routine)
	if coroutine.status(routines[routine].routine) == "dead" then
		routines[routine] = nil
		if routine == activeRoutine then
			--history[#history] = nil
			--[[for i,v in pairs(history) do
				if routine == v then
					table.remove(history,i)
				end
			end
			activeRoutine = history[#history]]--
			activeRoutine = "Debug1"
			routines[activeRoutine].window.setVisible(true)
		end
		return true
	else return false end
end

Kernel = {}

function Kernel.newRoutine(name,title,func,permission,...)
	log.log("System","Launching task "..name..". By kernel")
	local oldName = name
	local tries = 1
	while routines[name .. tries] do tries = tries + 1 end
	name = name .. tries
	if permission == "userTest" then
		log.log("System","Launching task "..name..": adding environment. By kernel")
		local env = Sandbox.newEnv(oldName)
		log.log("System","Environment was successful")
		setfenv(func,env)
	end

	routines[name] = {
		["title"] = title,
		["permission"] = permission,
		["path"] = path,
		["routine"] = coroutine.create(func),
		["window"] = OmniWindow.create(currTerm,1,1,w-1,h,true),
		["filter"] = "",
	}

	--Run it!
	if routines[activeRoutine] then
		term.redirect(routines[name].window)
		routines[name].window.setVisible(false)
		logMessage, routines[name].filter = coroutine.resume(routines[name].routine,...)
		if not logMessage then
			log.log(name,"Error: "..tostring(routines[name].filter),name)
		end
		term.redirect(currTerm)
		checkIfDead(name)
		--history[#history+1] = activeRoutine
		term.redirect(routines[activeRoutine].window)
		routines[activeRoutine].window.redraw()
	else
		activeRoutine = name
		term.redirect(routines[activeRoutine].window)
		routines[activeRoutine].window.setVisible(true)
		logMessage, routines[activeRoutine].filter = coroutine.resume(routines[activeRoutine].routine,...)
		if not logMessage then
			log.log(activeRoutine,"Error: "..tostring(routines[activeRoutine].filter),activeRoutine)
		end
		term.redirect(currTerm)
		checkIfDead(activeRoutine)
		--history[#history+1] = activeRoutine
	end
end



function Kernel.getPermission(program)
	return routines[program].permission or "Not a valid program"
end

function Kernel.kill(thread)
	if thread == "Debug1" then
		return "Cannot kill debug, instead use kill !zygote"
	else
		if thread == activeRoutine then
			activeRoutine = "Debug1"
			routines[activeRoutine].window.setVisible(true)
		end
		routines[thread] = nil
	end
end

function Kernel.list()
	local buffer = {}
	for i,v in pairs(routines) do
		buffer[#buffer+1] = i
	end
	return buffer
end

drawClosed()

Kernel.newRoutine(...)

while true do
	local event = #eventBuffer == 0 and {os.pullEventRaw()} or table.remove(eventBuffer,1)
	if (event[1] == "mouse_click" or event[1] == "monitor_touch") and event[3] == w then
		drawOpen()
		drawClosed()
		routines[activeRoutine].window.redraw()
	elseif eventFilter[event[1]] then
		if routines[activeRoutine].filter == nil or routines[activeRoutine].filter == "" or routines[activeRoutine].filter == event[1] then
			term.redirect(routines[activeRoutine].window)
			logMessage, routines[activeRoutine].filter = coroutine.resume(routines[activeRoutine].routine,unpack(event))
			if not logMessage then
				log.log(activeRoutine,"Error: "..tostring(routines[activeRoutine].filter),activeRoutine)
			end
			term.redirect(currTerm)
			checkIfDead(activeRoutine)
		end
	else
		for i,v in safePairs(routines) do
			if routines[i] then
				term.redirect(routines[i].window)
				logMessage, routines[i].filter = coroutine.resume(routines[i].routine,unpack(event))
				if not logMessage then
					log.log(i,"Error: "..tostring(routines[i].filter),i)
				end
				term.redirect(currTerm)
				checkIfDead(i)
			end
		end
	end
end