--[[
	Sandbox 
	environment
	by Creator
	for TheOS
]]--

--Variables--
local oldGetfenv = getfenv
local oldLoadfile = loadfile
--Functions--

function newEnv(permission)
	if permission == "admin" then
		return "global"
	else
		return "custom" , customEnv()
	end
end

local function makeDir(path)
	local parentPath = ""
	local buffer = {}
	for token in string.gmatch(path,"[^/]+") do
		buffer[#buffer+1] = token
	end
	for i=1,#buffer-1 do
		parentPath = parentPath.."/"..buffer[i]
	end
	local _,permission = isReadOnly(parentPath)
	if permission == "admin" then
		error("Operation not allowed, you have no power here...",2)
	elseif permission == "user" then
	
	elseif permission == "public" then
		fs.makeDir(path)
	end
end

local function copy(a,b)
	local function readFile(path)
		local file = fs.open(path,"r")
		local variable = file.readAll()
		file.close()
		return variable
	end
	
	local function writeFile(path,content)
		local file = fs.open(path,"w")
		file.write(content)
		file.close()
	end
	
	if fs.isDir(a) then
		local function explore(dir)
			local buffer = {}
			local sBuffer = fs.list(dir)
			for i,v in pairs(sBuffer) do
				sleep(0.05)
				if fs.isDir(dir.."/"..v) then
					buffer[v] = explore(dir.."/"..v)
				else
					buffer[v] = readFile(dir.."/"..v)
				end
			end
			return buffer
		end
		filesystem = explore("TheOS")
		
		function writeDown(input,dir)
			for i,v in pairs(input) do
				if type(v) == "table" then
					writeDown(v,dir.."/"..i)
				elseif type(v) == "string" then
					writeFile(dir.."/"..i,v)
				end
			end
		end
		writeDown(explore(a),b)
	else
		writeFile(b,readFile(a))
	end
end

local function isReadOnly(path)
	if fs.isDir(path) then
		if 
			
	else

	end
end

local function customEnv()
	return {
		redstone = redstone,
		gps = gps,
		_VERSION = _VERSION,
		keys = keys,
		printError = printError,
		peripheral = peripheral,
		assert = assert,
		getfenv = function(a)
			if type(a) == "number" then
				oldGetfenv(1)
			elseif type(a) == "function" then
				oldGetfenv(a)
			else
				error("Expected function or number, got "..type(a))
			end,
		bit = bit,
		rawset = rawset,
		tonumber = tonumber,
		loadstring = function(str) local func = loadstring(str) setfenv(func,getfenv(1))end,
		error = error,
		tostring = tostring,
		type = type,
		coroutine = { 
			create = coroutine.create,
			resume = coroutine.resume,
			running = coroutine.running,
			status = coroutine.status,
			wrap = coroutine.wrap,
		},
		disk = disk,
		window = window,
		next = next,
		unpack = unpack,
		colours = colours,
		pcall = pcall,
		sleep = sleep,
		loadfile = function(a) 
			local func = oldLoadfile(a)
			setfenv(func,getfenv(1))
			end,
		math = math,
		pairs = pairs,
		fs = {
			combine = fs.combine,
			isReadOnly = isReadOnly,
			getSize = fs.getSize,
			move = function(a,b)
				copy(a,b)
				fs.delete(a)
				end,
			exists = fs.exists,
			copy = copy(a,b)
			getFreeSpace = fs.getFreeSpace,
			makeDir = makeDir,
			find = fs.find,
			getDir = fs.getDir,
			delete = 
			open
			list
			getDrive
			getName
			isDir
		},
		rawget = rawget
		_G 
		__inext 
		read 
		rednet 
		ipairs 
		xpcall 
		os 
		help 
		io 
		rawequal 
		setfenv 
		rs 
		http 
		write 
		string 
		setmetatable 
		print 
		getmetatable 
		table 
		parallel 
		dofile 
		textutils 
		term 
		colors 
		vector 
		select 
		paintutils 
	},
end