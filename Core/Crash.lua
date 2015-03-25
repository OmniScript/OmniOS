os.pullEvent = os.pullEventRaw
tArgs = {...}

err = ""

term.redirect(term.native())
term.setBackgroundColor(colors.blue)
term.clear()
term.setTextColor(colors.white)
term.setCursorPos(2,4)
term.write("TheOS has crashed :(")
term.setCursorPos(2,6)
print("Click anywhere to restart the system, if the\n problem persists send the error message\n to Creator on the CC forums or to\n TheOnlyCreator on GitHub.")
term.setCursorPos(2,11)
term.write("Error message: ")
term.setCursorPos(4,13)
for i,v in pairs(tArgs) do
	err = err.." "..v
end
term.write(err)
log.log("Error",err,"Missing")
os.pullEvent("mouse_click")
--os.reboot()