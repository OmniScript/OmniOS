args = {...}
local sPath = args[1]
local filesystem = {}

local function readFile(path)
	local file = fs.open(path,"r")
	local variable = file.readAll()
	file.close()
	return variable
end

filesystem = textutils.unserialize(readFile(sPath))


local function writeFile(path,content)
	local file = fs.open(path,"w")
	file.write(content)
	file.close()
end
	
function writeDown(input,dir)
	for i,v in pairs(input) do
		if type(v) == "table" then
			writeDown(v,dir.."/"..i)
		elseif type(v) == "string" then
			writeFile(dir.."/"..i,v)
		end
	end
end
writeDown(filesystem,"TheOS")
