--[[
	The Aware Project
	by Creator
	for TheOS
]]--
--[[
	First I am doing the mechanics of the program, afterwards I will do the GUI
]]--

--GUI
--if _G.Interact == nil then os.loadAPI("TheOS/API/Interact") end
--local gui = Interact.Initialize()

--Variables--
local input = {}
local Commands = {}
local path = "TheOS/Programs/Aware.app/"
local UselessWords = {}
--Functions--

function split(str,sep)
	local buffer = {}
	for token in str:gmatch(sep) do
		buffer[#buffer+1] = token
	end
	return buffer
end

function getData()
	local var = http.get("https://raw.githubusercontent.com/TheOnlyCreator/Aware/master/Test/Test")
	print(var.readAll())
	os.pullEvent()
	error()
end

local function readFile(_path)
	local file = fs.open(_path,"r")
	local data = file.readAll()
	file.close()
	return data
end

function filter(input)
	local buffer = {}
	for i,v in pairs(input) do
		if UselessWords[v] == true then
			buffer[#buffer+1] = i
		end
	end
	for i,v in pairs(buffer) do
		input[i] = nil
	end
	buffer = {}
	for i,v in pairs(input) do
		local sBuffer = {}
		local f = ""
		for token in string.gmatch(v,"[%a]+") do
			sBuffer[#sBuffer+1] = token
		end
		for i,v in pairs(sBuffer) do
			f = f..v
		end
		buffer[#buffer+1] = f
	end
	return buffer
end

function redirect(word)
	word = string.lower(word)
	oneWordCommand(word)
end

function wordSet(arg)
	local fromWeb = http.get("https://raw.githubusercontent.com/CodingRevolution/Aware/master/WordSets/"..arg)
	local buffer = fromWeb.readAll()
	return split(buffer,"[^\n]+")
end

function randomElement(input)
	local element
	local buffer = {}
	for i,v in pairs(input) do
		buffer[#buffer+1] = i
	end
	local rnd = buffer[math.random(1,#buffer)]
	return input[rnd]
end

function oneWordCommand(word)
	if Commands[word] ~= nil then
		local func = loadstring(Commands[word])
		setfenv(func, getfenv())
		func()
	else
		local firstLetter = string.sub(word,1,1)
		print(firstLetter)
		print(word)
		local fromWeb = http.get("https://raw.githubusercontent.com/CodingRevolution/Aware/master/Actions/"..firstLetter)
		local buffer = fromWeb.readAll()
		local tableFromWeb = textutils.unserialize(buffer)
		print(tableFromWeb[word])
		local func = loadstring(tableFromWeb[word])
		setfenv(func, getfenv())
		func()
	end
end

function main()
	print("I am listening...")
	local buffer = read()
	input = split(buffer,"[^%s]+")
	for i,v in pairs(input) do
		input[i] = string.lower(v)
	end
	if #input == 1 then
		oneWordCommand(input[1])
	else
		oneWordCommand(filter(input)[1])
	end
end


--Code--
local buffer = readFile(path.."Commands")
Commands = textutils.unserialize(buffer)

local buffer = readFile(path.."UselessWords")
buffer = split(buffer,"[^\n]+")
for i,v in pairs(buffer) do
	UselessWords[v] = true
end

term.setCursorPos(1,1)
term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()

while true do
	main()
end