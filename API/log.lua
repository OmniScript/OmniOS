--[[
	Log API
	by Creator
	for TheOS
]]--

function log(destination,message,app)
	local finalMsg = "["..os.day()..":"..os.time().."]"
	if app then
		finalMsg = finalMsg..".["..tostring(app).."]:"..tostring(message)
	else
		finalMsg = finalMsg..":"..tostring(message)
	end
	local m = fs.open("OmniOS/Logs/"..destination..".log","a")
	m.write(finalMsg.."\n")
	m.close()
end