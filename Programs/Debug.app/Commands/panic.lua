OmniOS.debug.run("kill !all")
os.pullEvent = os.pullEventRaw
local countdown = 1000
while true do
	print("We're under attack")
	print("System will self destroy in "..tostring(countdown).." seconds")
	sleep(1)
	countdown = countdown - 1
	if countdown == 0 then error() end
end