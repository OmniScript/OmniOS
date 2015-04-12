--[[
	Calculator App
	for OmniOS by
	Creator
]]--

--Varialbles--
local gui = {}
local path = OmniOS and "OmniOS/Programs/Calculator.app/Data/" or "Calculator"
term.clear()
term.setCursorPos(1,1)
print(path)
os.pullEvent()