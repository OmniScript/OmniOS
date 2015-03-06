transparentIcon = "-"
args = {...}
tX, tY = term.getSize()

function drawImage(file,xSet,ySet,redirection)
 init()
 lastImage = file
 lastX = xSet
 lastY = ySet
 lastRedirection = redirection
 if redirection then
  current = term.current()
  term.redirect(redirection)
 end
 drawData(xSet,ySet,file)
 if redirection then
  term.redirect(current)
 end
end

function overWrite(textSet,xSet,ySet,colorSet)
 init()
 exists = true
 if not lastImage then
  error("Use drawImage first!")
 end
 if not writeBuffer then
  writeBuffer = {}
 end
 if not writeBuffer[lastImage] then
  writeBuffer[lastImage] = {}
 end
 plusPos = 0
 for char in string.gmatch(textSet,".") do
  if not writeBuffer[lastImage][xSet+plusPos] then
   writeBuffer[lastImage][xSet+plusPos] = {}
  end
  if not writeBuffer[lastImage][xSet+plusPos][ySet] then
   writeBuffer[lastImage][xSet+plusPos][ySet] = {colors.black," ",colors.white}
  end
  writeBuffer[lastImage][xSet+plusPos][ySet][2] = char
  writeBuffer[lastImage][xSet+plusPos][ySet][3] = colorSet
  plusPos = plusPos + 1 
 end
 drawImage(lastImage,lastX,lastY,lastRedirection)
end

function init()
function eventHandler()
 while true do
  event = {os.pullEvent()}
  if event[1] == "key" then
   if event[2] == keys.leftCtrl or event[2] == 157 then
    menuStatus = not menuStatus
    writeMenuBar(menuStatus)
   end
   if menuStatus == true then
    if event[2] == keys.right or event[2] == keys.left then
     if menuItemSelected == 1 then
      menuItemSelected = 2
     else
      menuItemSelected = 1
     end
     writeMenuBar(menuStatus)
    elseif event[2] == keys.enter then
     if menuItemSelected == 1 then
      save()
      writeMenuBar(false)
     else
      term.setTextColor(colors.yellow)
      term.setBackgroundColor(colors.black)
      term.clear()
      term.setCursorPos(1,1)
      error()
     end
    end
   else   
    if event[2] == keys.right then
     drawData(offSetX-1,offSetY)
     drawMenu()
     writeMenuBar(menuStatus)
    elseif event[2] == keys.left then
     drawData(offSetX+1,offSetY)
     drawMenu()
     writeMenuBar(menuStatus)
    elseif event[2] == keys.up then
     drawData(offSetX,offSetY+1)
     drawMenu()
     writeMenuBar(menuStatus)
    elseif event[2] == keys.down then
     drawData(offSetX,offSetY-1)
     drawMenu()
     writeMenuBar(menuStatus)
    end
   end
  end
  if event[1] == "mouse_click" or event[1] == "mouse_drag" then
   if event[3] > 2 and event[4] ~= tY then
    insertItem(event[3],event[4],event[2])
   elseif event[4] < 18 and event[4] > 1 then
    if event[3] == 1 then
     bgSelected = 2^(event[4]-2)
    elseif event[3] == 2 then
     tSelected = 2^(event[4]-2)
    end
    drawMenu()
   elseif event[4] == tY - 1 and event[3] == 1 then
    setLetter()
    drawData(offSetX,offSetY)
    drawMenu()
   elseif event[3] == tX and event[4] == tY and menuStatus == false then
    writeHelp()
   end
  end
  if event[1] == "char" then
   textSelected = string.sub(event[2],1,1)
   drawMenu()
  end
  --drawData(offSetX,offSetY)
 end
end

function writeHelp()
 term.setBackgroundColor(colors.black)
 term.setTextColor(colors.green)
 term.clear()
 term.setCursorPos(1,1)
 term.write("Help:")
 term.setTextColor(colors.white)
 term.setCursorPos(1,3)
 print("Usage:")
 term.setTextColor(colors.lightGray)
 print("  Select color: Click on the color on the left")
 print("  Change draw char: Press a key on the keyboard")
 print("  Change transparent icon: Click on the icon's char in the menu")
 print("  Change text color: Click on a color in the menu on the right side")
 print("  Change background color: Click on a color in the menu on the left side")
 term.setTextColor(colors.white)
 print()
 print("Controls:")
 term.setTextColor(colors.lightGray)
 print("  Arrow keys to pan")
 print("  Left mouse button to select and draw")
 print("  Right mouse button to delete")
 print("  Ctrl to open menu")
 print()
 term.setTextColor(colors.white)
 term.write("Click a mouse button to exit.")
 term.setTextColor(colors.orange)
 term.setCursorPos(tX-9,1)
 term.write("API help >")
 event = {os.pullEvent("mouse_click")}
 if event[3] > tX-10 and event[4] == 1 then
  drawAPIhelp()
 end
 drawData(offSetX,offSetY)
 drawMenu()
 writeMenuBar(menuStatus)
end

function drawAPIhelp()
 term.clear()
 term.setCursorPos(1,1)
 term.setTextColor(colors.orange)
 print("API help menu:")
 print()
 term.setTextColor(colors.white)
 print("Drawing an image: ")
 term.setTextColor(colors.lightGray)
 print(shell.getRunningProgram(),".drawImage(<file name>,<x pos>,<y pos>,[redirection object])")
 print()
 term.setTextColor(colors.white)
 print("Overlaying text on the last image:")
 term.setTextColor(colors.lightGray)
 print(shell.getRunningProgram(),".overWrite(<Text>,<x pos>,<y pos>,<text color>")
 print()
 term.setTextColor(colors.red)
 print("Overwriting text will only work AFTER drawing an image!")
 term.setTextColor(colors.white)
 print()
 print("Example:")
 term.setTextColor(colors.lightGray)
 print("os.loadAPI(\"",shell.getRunningProgram(),"\")")
 print(shell.getRunningProgram(),".drawImage(\"myPicture\",1,1)")
 print(shell.getRunningProgram(),".overWrite(\"Hello!\",2,3,colors.orange)")
 os.pullEvent("mouse_click")
end

function setLetter()
 term.setBackgroundColor(colors.red)
 term.setTextColor(colors.black)
 for i=1,4 do
  term.setCursorPos(tX/2-11,(tY/2-4)+i)
  term.write("                     ")
 end
 term.setCursorPos(tX/2-10,tY/2-2)
 term.write("Change transparancy")
 term.setCursorPos(tX/2-10,tY/2-1)
 term.write("character to: (key)")
 event = {os.pullEvent("char")}
 transparentIcon = event[2]
end

function insertItem(xPos,yPos,modeSet)
 if saved == true then
  saved = false
  writeMenuBar(false)
 end
--bgSelected
--tSelected
--textSelected
 if not painted then
  painted = {}
 end
 if not painted[xPos-offSetX] then
  painted[xPos-offSetX] = {}
 end
 if modeSet == 1 then
   if not textSelected then
    textSelected = " "
   end
   TMPtextSelected = textSelected
   painted[xPos-offSetX][yPos-offSetY] = {bgSelected,textSelected,tSelected}
   term.setBackgroundColor(bgSelected)
   term.setTextColor(tSelected)
  else
   TMPtextSelected = transparentIcon
   term.setBackgroundColor(colors.black)
   term.setTextColor(colors.gray)
   painted[xPos-offSetX][yPos-offSetY] = nil
 end
 term.setCursorPos(xPos,yPos)
 term.write(TMPtextSelected)
end

--if #args ~= 1 then
-- print("Usage: "..shell.getRunningProgram().." <path>")
-- return
--end

if args[1] and fs.exists(args[1]) == true then
 buff = fs.open(args[1],"r")
 previousData = buff.readAll()
 buff.close()
 processed = string.sub(previousData,43)
 painted = textutils.unserialize(processed)
else
 painted = {}
end

function save()
 file = fs.open(args[1],"w")
 file.write("error('This is an image, not a program!')\n"..textutils.serialize(painted))
 file.close()
 saved = true
end

function drawData(xStart, yStart, file)
 offSetX = xStart
 offSetY = yStart
 if not file then
  term.setBackgroundColor(colors.black)
  term.setTextColor(colors.gray)
  transparentLine = ""
  for x=1,tX-2 do
   transparentLine = transparentIcon..transparentLine
  end
  for y=1,tY-1 do
   term.setCursorPos(3,y)
   term.write(transparentLine)
  end
 else
  if fs.exists(file) == false then
   error("File given doesnt exists! file name: "..file)
  else
   local fileD = fs.open(file,"r")
   raw = fileD.readAll()
   --ignoreL = string.len(fileD.readLine(1))
   processed = string.sub(raw,43)
   --term.redirect(term.native())
  -- textutils.pagedPrint(processed)
   painted = textutils.unserialize(processed)
   fileD.close()
  end
 end
 if not painted then
  painted = {}
 end
 paintedF = painted
 count = 0
 repeat ---------
 count = count + 1
 for xPos,v in pairs(paintedF) do
  for yPos in pairs (paintedF[xPos]) do
    overWrite = true
    if not lastImage or not writeBuffer or not writeBuffer[lastImage] then
     overWrite = false
    end
    if overWrite == true then
     if not writeBuffer[lastImage][xPos] then
      overWrite = false
     end
    end
    if overWrite == true then
     if not writeBuffer[lastImage][xPos][yPos] then
      overWrite = false
     end
    end
    if overWrite == false then
     bgColor = paintedF[xPos][yPos][1]
     text = paintedF[xPos][yPos][2]
     tColor = paintedF[xPos][yPos][3]
    else
     if painted and painted[xPos] and painted[xPos][yPos] and painted[xPos][yPos][1] then
      bgColor = painted[xPos][yPos][1]
      else
      bgColor = colors.black
     end
     --if not bgColor then
    --  bgColor = colors.black
     --end
     text = writeBuffer[lastImage][xPos][yPos][2]
     tColor = writeBuffer[lastImage][xPos][yPos][3]
    end
    if not tColor then
     tColor = colors.white
    end
    if not text then
     text = " "
    end
    term.setCursorPos(xPos+xStart,yPos+yStart)
    term.setBackgroundColor(bgColor)
    term.setTextColor(tColor)
    term.write(text)
   end
  end
  if count == 1 and writeBuffer and lastImage then
   paintedF = writeBuffer[lastImage]
  elseif count == 1 and not lastImage or not writeBuffer then
   count = 2
  end
 until count == 2
 term.setCursorPos(1,tY)
end

function drawMenu()
 term.setCursorPos(1,1)
 term.setTextColor(colors.white)
 if not bgSelected then
  bgSelected = colors.black
 elseif bgSelected == colors.white then
  term.setTextColor(colors.black)
 end
 if not tSelected then
  tSelected = colors.white
 elseif tSelected == colors.white then
  term.setTextColor(colors.black)
 end
 if not textSelected then
  textSelected = " "
 end
 term.setBackgroundColor(bgSelected)
 term.write("B")
 term.setBackgroundColor(tSelected)
 term.write("T")
 for i=1,16 do
  i=i-1
  term.setCursorPos(1,i+2)
  term.setBackgroundColor(2^i)
  term.write("  ")
 end
 term.setCursorPos(1,18)
 term.setBackgroundColor(colors.black)
 if not textSelected then
  textSelected = " "
 elseif string.len(textSelected) > 1 then
  textSelected = string.sub(textSelected,1,1)
 end
 term.setTextColor(colors.gray)
 term.setBackgroundColor(colors.black)
 term.write(transparentIcon)
 term.setTextColor(tSelected)
 term.setBackgroundColor(bgSelected)
 term.write(textSelected)
end

function writeMenuBar(booly)
 menuStatus = booly
 term.setBackgroundColor(colors.black)
 if booly == true then
  term.setCursorPos(1,tY)
  term.clearLine()
  if not menuItemSelected then
   menuItemSelected = 1
  end
  term.setTextColor(colors.white)
  term.write(" Save  Exit ")
  term.setCursorPos(6*menuItemSelected-5,tY)
  term.setTextColor(colors.yellow)
  term.write("[")
  term.setCursorPos(6*menuItemSelected,tY)
  term.write("]")
 elseif booly == false then
  term.setCursorPos(1,tY)
  term.setTextColor(colors.yellow)
  term.clearLine()
  if saved == true then
   term.write("Saved to "..args[1])
  else
   term.write("Press Ctrl to access menu")
  end
  term.setCursorPos(tX,tY)
  term.setTextColor(colors.lightGray)
  term.write("?")
 end
end
end

if #args > 0 then
 init()
 menuStatus = false
 saved = false
 writeMenuBar(menuStatus)
 menuItemSelected = 1
 drawData(3,0)
 drawMenu()
 eventHandler()
end