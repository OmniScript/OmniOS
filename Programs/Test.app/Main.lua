while true do
term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1,1)
print("Protocol is initializng...")
if System then 
	print("System API has been loaded..")
	print("The available methods are:")
	for i,v in pairs(System) do
		print(" - "..i)
	end
	print("Done")
else
	print("System API has not been loaded..")
end
os.pullEvent()
System.newTask("FileX","FileX")
end