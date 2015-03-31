function getSides(sInput)
	local sides = {}
	for token in string.gmatch(sInput,"[^=]+") do
		sides[#sides+1] = token
	end
	return sides[1], sides[2]
end

function getMolecules(sInput)
	local buffer = {}
	for token in string.gmatch(sInput,"[^%s]+") do
		buffer[#buffer+1] = token
	end
	return buffer
end


local left, right = getSides(equation)

left = getMolecules(left)
right = getMolecules(right)