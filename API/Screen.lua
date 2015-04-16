function new( parent, nX, nY, nWidth, nHeight)

	if type( parent ) ~= "table" then error( "Expected object",2 ) end
	if type( nX ) ~= "number" then error( "Expected number1", 2 ) end
	if type( nY ) ~= "number" then error( "Expected number2", 2 ) end
	if type( nWidth ) ~= "number" then error( "Expected number3", 2 ) end
	if type( nHeight ) ~= "number" then error( "Expected number4", 2 ) end

	if parent == term then
		parent = term.current()
	end

	-- Setup
	local nCursorX = 1
	local nCursorY = 1

	-- Helper functions
	local function updateCursorPos()
		if nCursorX >= 1 and nCursorY >= 1 and
		   nCursorX <= nWidth and nCursorY <= nHeight then
			parent.setCursorPos( nX + nCursorX - 1, nY + nCursorY - 1 )
		else
			parent.setCursorPos( 0, 0 )
		end
	end

	local window = {}

	-- Terminal implementation
	function window.write( sText )
		local nLen = sText:len()
		updateCursorPos()
		for i = 1, nLen do
			if nCursorX <= nWidth and nCursorY <= nHeight then
				parent.write(sText:sub(i,i))
				nCursorX = nCursorX + 1
			end
		end
	end

	local function clearLine()
		for i=1,nWidth do
			parent.write(" ")
			nCursorX = nCursorX + 1
		end
	end

	function window.clear()
		for m=1, nHeight do
			updateCursorPos()
			clearLine()
			nCursorY = nCursorY + 1
		end
	end

	function window.clearLine()
		clearLine()
	end

	function window.getCursorPos()
		return nCursorX, nCursorY
	end

	function window.setCursorPos( x, y )
		nCursorX = math.floor( x )
		nCursorY = math.floor( y )
		updateCursorPos()
	end

	function window.setCursorBlink( blink )
		parent.setCursorBlink(blink)
	end

	function window.isColor()
		return parent.isColor()
	end

	function window.isColour()
		return parent.isColor()
	end

	local function setTextColor( color )
		if not parent.isColor() then
			if color ~= colors.white and color ~= colors.black then
				error( "Colour not supported", 3 )
			end
		end
		parent.setTextColour(color)
	end

	function window.setTextColor( color )
		setTextColor( color )
	end

	function window.setTextColour( color )
		setTextColor( color )
	end

	local function setBackgroundColor( color )
		if not parent.isColor() then
			if color ~= colors.white and color ~= colors.black then
				error( "Colour not supported", 3 )
			end
		end
		parent.setBackgroundColor(color)
	end

	function window.setBackgroundColor( color )
		setBackgroundColor( color )
	end

	function window.setBackgroundColour( color )
		setBackgroundColor( color )
	end

	function window.getSize()
		return nWidth, nHeight
	end

	function window.scroll( n )
		print("Fuck you! No freaking buffer.")
	end

	return window
end
