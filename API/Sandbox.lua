--[[
	Sandbox 
	environment
	by Creator
	for TheOS
]]--

--Variables--
local oldGetfenv = getfenv
local oldLoadfile = loadfile
local globalName = ""

--Functions--

function newEnv(name)
	globalName = name
	log.log("Sandbox",globalName)
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
			end end,
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
			isReadOnly = function(path) return fs.isReadOnly("OmniOS/Programs/"..globalName..".app/"..path) end,
			getSize = function(path) return fs.getSize("OmniOS/Programs/"..globalName..".app/"..path) end,
			move = function(path1,path2) return fs.move("OmniOS/Programs/"..globalName..".app/"..path1,"OmniOS/Programs/"..globalName..".app/"..path2) end,
			exists = function(path) return fs.exists("OmniOS/Programs/"..globalName..".app/"..path) end,
			copy = function(path1,path2) return fs.copy("OmniOS/Programs/"..globalName..".app/"..path1,"OmniOS/Programs/"..globalName..".app/"..path2) end,
			getFreeSpace = function(path) return fs.getFreeSpace("OmniOS/Programs/"..globalName..".app/"..path) end,
			makeDir = function(path) return fs.makeDir("OmniOS/Programs/"..globalName..".app/"..path) end,
			find = function(path) return fs.find("OmniOS/Programs/"..globalName..".app/"..path) end,
			getDir = fs.getDir,
			delete = function(path) return fs.delete("OmniOS/Programs/"..globalName..".app/"..path) end,
			open = function(path,...) return fs.open("OmniOS/Programs/"..globalName..".app/"..path,...) end,
			list = function(path) return fs.list("OmniOS/Programs/"..globalName..".app/"..path) end,
			getDrive = function(path) return fs.getDrive("OmniOS/Programs/"..globalName..".app/"..path) end,
			getName = fs.getName,
			isDir = function(path) return fs.isDir("OmniOS/Programs/"..globalName..".app/"..path) end,
		},
		rawget = rawget,
		_G = envToReturn,
		__inext = __inext,
		read = read,
		rednet = rednet,
		ipairs = ipairs,
		xpcall = xpcall,
		os = os,
		help = help,
		io = io,
		rawequal = rawequal,
		setfenv = setfenv,
		rs = rs,
		http = http,
		write = write,
		string = string,
		setmetatable = setmetatable,
		print = print,
		getmetatable = getmetatable,
		table = table,
		parallel = parallel,
		dofile = function(path) dofile("OmniOS/Programs/"..globalName..".app/"..path) end,
		textutils = textutils,
		term = term,
		colors = colors,
		vector = vectors,
		select = select,
		paintutils = paintutils,
		System = System,
		OmniOS = OmniOS,
	}
end