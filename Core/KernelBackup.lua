--[[
	TheOS Kernel
	by Creator
	for TheOS &
	you to learn
	from it! (Yeah learn, rather become dumber)
	theoriginalbit
	also gets credit for 
	his safePairs function.
]]--

local args = {...}
local w,h = term.getSize()
local currTerm = term.current()
local routines = {}
local routinesToKill = {}
local activeRoutine = ""
local eventGlobal = true
local halfH = math.floor(h/2 +2)
local first = true

local function drawClosed()
	paintutils.drawLine(w,1,w,h,colors.black)
	term.setTextColor(colors.white)
	term.setBackgroundColor(colors.black)
	term.setCursorPos(w,halfH)
	term.write("<")
end

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

local function drawOpen()
	paintutils.drawFilledBox(w-15,1,w,h,colors.black)
	local xVsProcess = {}
	local curr = 1
	term.setTextColor(colors.white)
	for i,v in pairs(routines) do
		term.setCursorPos(w-14,(curr*2))
		term.write("x "..v.title)
		term.setCursorPos(w-12,(curr*2)+1)
		term.write(coroutine.status(v.routine))
		xVsProcess[curr*2] = v.ID
		curr = curr + 1
	end
	local notH = true
	local switchRoutine = false
	local toDelete = false
	while notH do
		evnt = {os.pullEventRaw("mouse_click")}
		if w-12 <= evnt[3] and evnt[3] <= w then
			print(event[3])
			if xVsProcess[evnt[4]] ~= nil then
				notH = false
				switchRoutine = true
			end
		elseif w-14 == evnt[3] then
			term.setCursorPos(evnt[3],evnt[4])
			--print("yes")
			if xVsProcess[evnt[4]] ~= nil then
				--print("himom")
				notH = false
				toDelete = true
			end
		else
			notH = false
		end
	end
	print(toDelete)
	if switchRoutine then
		routines[activeRoutine].window.setVisible( false )
		activeRoutine = xVsProcess[evnt[4]]
		routines[activeRoutine].window.setVisible(true)
	elseif toDelete then
		if activeRoutine == xVsProcess[evnt[4]] then print("Changing to "..xVsProcess[evnt[4]]) activeRoutine = "Desktop1" end
		if not xVsProcess[evnt[4]] == "Desktop1" then
			routines[xVsProcess[evnt[4]]] = nil
		end
		--term.redirect(routines[activeRoutine].window)
		routines[activeRoutine].window.setVisible(true)
	end
end

function newRoutine(name,title,func,...)
	name = name.."1"
	--if not routines[name] then
		local notUnique = true
		local tries = 1
		while notUnique do
			tries = tries + 1
			if routines[name] ~= nil then
				name = name:sub(1,-2)..tostring(tries)
			else
				notUnique = false
			end
		end
		local arguments = {...}
		routines[name] = {}
		routines[name].routine = coroutine.create(func)
		--if first then
			routines[name].window = window.create(term.current(),1,1,w-1,h,true)
			activeRoutine = name
			--first = false
		--else
		--	routines[name].window = window.create(term.current(),1,1,w-1,h,false)
		--end
		routines[name].title = title
		routines[name].ID = name
		routines[name].permission = permission
		routines[name].path = path
		--Run it!
		routines[activeRoutine].window.setVisible(false)
		activeRoutine = name
		term.redirect(routines[activeRoutine].window)
		routines[activeRoutine].window.setVisible(true)
		coroutine.resume(routines[activeRoutine].routine,unpack(arguments))
		term.redirect(currTerm)
	--end
end

local function checkIfDead(routine)
	local wasDead = false
	status = coroutine.status(routines[routine].routine)
	--print(routine.."."..status)
	if status == "dead" then
		wasDead = true
		routines[activeRoutine].window.setVisible(false)
		routines[routine] = nil
		if routine == activeRoutine then activeRoutine = "Desktop1" end
		routines[activeRoutine].window.setVisible(true)
	end
	return wasDead
end

local function main()
	while true do
		routinesToKill = {}
		event = {os.pullEventRaw()}
		if (event[1] == "mouse_click" or event[1] == "monitor_touch") and event[3] == w then
			drawOpen()
			term.setBackgroundColor(colors.black)
			term.clear()
			drawClosed()
			routines[activeRoutine].window.redraw()
		elseif event[1] == "key" or event[1] == "mouse_click" or event[1] == "monitor_touch" or event[1] == "paste" or event[1] == "char" or event[1] == "mouse_scroll" or event[1] == "mouse_drag" or event[1] == "terminate" then
			if not checkIfDead(activeRoutine) then
				term.redirect(routines[activeRoutine].window)
				--routines[activeRoutine].window.redraw()
				coroutine.resume(routines[activeRoutine].routine,unpack(event))
				term.redirect(currTerm)
			end
		else
			for i,v in safePairs(routines) do
				if not checkIfDead(i) then
					term.redirect(routines[i].window)
					coroutine.resume(routines[i].routine,unpack(event))
					term.redirect(currTerm)
				end
			end
		end
	end
end


drawClosed()

newRoutine(unpack(args))

main()