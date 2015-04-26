print("The commands are:")
for i,v in pairs(fs.list("OmniOS/Programs/Debug.app/Commands")) do
	print(" "..v:match("[^.]+"))
end