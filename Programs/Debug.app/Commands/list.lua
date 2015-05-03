term.write("The threads are:")
for i,v in pairs(Kernel.list()) do
	print()
	term.write(" "..v)
end