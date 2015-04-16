--[[
	Calculator App
	for OmniOS by
	Creator
]]--

--Varialbles--
local gui = {}
local path = OmniOS and "OmniOS/Programs/Calculator.app/Data/" or "Calculator/"
local MainLayout = {}
local env = {
	deg = math.deg,
	fmod = math.fmod,
	random = math.random,
	asin = math.asin,
	max = math.max,
	modf = math.modf,
	log10 = math.log10,
	floor = math.floor,
	cosh = math.cosh,
	ldexp = math.ldexp,
	log = math.log,
	pow = math.pow,
	rndsd = math.randomseed,
	frexp = math.frexp,
	abs = math.abs,
	tanh = math.tanh,
	acos = math.acos,
	atan2 = math.atan2,
	tan = math.tan,
	min = math.min,
	ceil = math.ceil,
	sinh = math.sinh,
	sqrt = math.sqrt,
	huge = math.huge,
	rad = math.rad,
	sin = math.sin,
	exp = math.exp,
	cos = math.cos,
	atan = math.atan,
	pi = math.pi,
}

--Functions--
local function readLayoutFile(sLayout)
	local func, err = loadfile(path.."Layouts/"..sLayout..".layout")
	if err then
		log.log("Calculator",err)
	end
	setfenv(func,_G)
	return func()
end


--Code--
if not OmniOS or not Interact then
	shell.run("pastebin --- Interact")
	os.loadAPI("Intearct")
end
gui = NewInteract:Initialize()
print(type(NewInteract:Initialize()))
os.pullEvent()
MainLayout = gui.Layout.new(readLayoutFile("Main"))
--gui.loadLayout(gui.loadObjects(),MainLayout)
local input = gui.Text.new({name = "input",text = "",xPos = 1,yPos = 2,bgColor = colors.orange,fgColor = colors.white})

MainLayout:draw()
while true do
	MainLayout.ColorField.Top:draw()
	MainLayout.Button.Exit:draw()
	MainLayout.Button.Clear:draw()
	MainLayout.Button.Delete:draw()
	input:draw()
	local MainLayoutEvent = gui.eventHandler(MainLayout)
	if MainLayoutEvent[2] == "=" then
		local fOutput = setfenv(loadstring("return "..input.text),env)
		local ok, output = pcall(fOutput)
		if not ok then 
			log.log("Calculator",output,"Calculator")
		end
		input.text = output
		input:draw()
	elseif MainLayoutEvent[2] == "Exit" then
		break
	elseif MainLayoutEvent[2] == "Clear" then
		input.text = ""
	elseif MainLayoutEvent[2] == "Delete" then
		input.text = input.text:sub(1,-2)
	else
		input.text = input.text..MainLayoutEvent[2]
	end
end