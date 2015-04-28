--OmniOS: Boot--
--by Creator--

--Variables--
local tasks = 2
local finishedTasks = 0
term.redirect(term.native())
local w,h = term.getSize()
local textutilsserialize = textutils.serialize
local textutilsunserialize = textutils.unserialize
local APIlist = {}
local oldPullEvent = os.pullEvent
local whichLang = nil
local lang = {}
local oldFs = {}
local logo  = paintutils.loadImage("OmniOS/Media/Boot/Boot_Logo.nfp")
local hideLogo = paintutils.loadImage("OmniOS/Media/Boot/Boot_Hide.nfp")
local logoWide = 18
--Functions--

function nPrint(text)
	finishedTasks = finishedTasks + 1
	local txt = "OmniOS by Creator"
	term.setBackgroundColor(colors.white)
	term.setTextColor(colors.lightGray)
	term.clear()
	term.setCursorPos(math.floor((w-#txt)/2),math.floor(h/2)-1)
	term.write(txt)
	term.setTextColor(colors.gray)
	term.setCursorPos(math.floor((w-#text)/2),math.floor(h/2))
	term.write(text)
	paintutils.drawImage(logo,math.floor((w-logoWide)/2),math.floor(h/2)+3)
	paintutils.drawImage(hideLogo,math.floor((w-logoWide)/2)+math.ceil((finishedTasks/tasks)*logoWide),math.floor(h/2)+3)
	sleep(.2)
end

--Code--

term.setTextColor(colors.white)
term.setBackgroundColor(colors.white)
term.clear()
term.setCursorPos(1,1)

--Load language file--
langFile = fs.open("OmniOS/Settings/Language/CurrentLang","r")
whichLang = langFile.readAll()
langFile.close()

langFile = fs.open("OmniOS/Languages/Boot_"..whichLang..".lang","r")
lang = textutilsunserialize(langFile.readAll())
langFile.close()

--Load APIs--
nPrint(lang[3])
dofile("OmniOS/Core/LoadAPIs.lua")
nPrint(lang[4])

--Overwrite os.pullEventFunctions--
--oldPullEvent = os.pullEvent
--os.pullEvent = os.pullEventRaw

--Go to next
function goOn()
	local login, err = loadfile("OmniOS/Core/Login.lua")
	if err then print(err) log.log("Error",err) os.pullEvent() end
	--login()
	local kernel, err= loadfile("OmniOS/Core/Kernel.lua")
	if err then print(err) os.pullEvent() log.log("Error",err) end
	local startup, err = loadfile("OmniOS/Programs/Debug.app/Main.lua")
	if err then print(err) os.pullEvent() log.log("Error",err) end
	kernel("Debug","Debug",startup,"admin")
end

ok, err = pcall(goOn)

if not ok then
	log.log("Crash",err)
	pcall(shell.run("OmniOS/Core/Crash.lua "..err))
end