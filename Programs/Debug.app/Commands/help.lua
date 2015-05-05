local tArgs = {...}
help = tArgs[1]
local p = print
if help == "cmds" then
	p("Usage: cmds")
	p("  Prints all the commands. ")
elseif help == "kill" then
	p("Usage: kill <process>")
	p("  Kils the specified process")
	p("  !all will terminate every process except Debug1.")
	p("  !zygote will terminate every process.")
elseif help == "launch" then
	p("Usage: launch <app>")
	p("  Will launch an app on the terminal")
elseif help == "list" then
	p("Usage: list")
	p("  Lists the processes.")
elseif help == "logs" then
	p("Usage: logs <log>")
	p("  Deletes the specified log.")
	p("  !all will delete all the logs.")
elseif help == "ls" then
	p("Type help list")
elseif help == "monitor" then
	p("Usage: monitor <action> <args>")
	p("  What each action does:")
	p("Launch:")
	p("  Usage: monitor launch <monitor> <app>")
	p("  Is the same as launch, but uses a monitor instead.")
	p("List:")
	p("  Lists the available monitors.")
else
	p("Usage: help <command>")
end