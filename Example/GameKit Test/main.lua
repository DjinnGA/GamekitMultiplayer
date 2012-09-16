require "gamekit"

-- Connect Button
local connectBtn = display.newRect(60, 15, 200, 50)
--Green
connectBtn:setFillColor(0,255,0)
stage:addChild(connectBtn)

-- Disconnect Button
local disconnectBtn = display.newRect(60, screenH-65, 200, 50)
--Red
disconnectBtn:setFillColor(255,0,0)
stage:addChild(disconnectBtn)

-- Send String Button
local sendBtn = display.newRect(60, screenH/2-62, 200, 50)
--Blue
sendBtn:setFillColor(0,0,255)
stage:addChild(sendBtn)

-- Send Table Button
local sendTblBtn = display.newRect(60, screenH/2+62, 200, 50)
--Turqoise
sendTblBtn:setFillColor(0,255,255)
stage:addChild(sendTblBtn)

-- Show Peer Picker
local function showPeerPicker(sender, event)
	if sender:hitTestPoint(event.x, event.y) then
		print("Showing Peer Picker")
		gamekit:btConnect()
	end
end
connectBtn:addEventListener(Event.MOUSE_UP, showPeerPicker, connectBtn)

-- Disconnect From Peers
local function disconnectNow(sender, event)
	if sender:hitTestPoint(event.x, event.y) then
		print("Disconnecting All Peers")
		gamekit:btDisconnectAll()
	end
end
disconnectBtn:addEventListener(Event.MOUSE_UP, disconnectNow, disconnectBtn)

-- Send String
local function sendString(sender, event)
	if sender:hitTestPoint(event.x, event.y) then
		print("Sending String")
		gamekit:btSendString("Test String")
	end
end
sendBtn:addEventListener(Event.MOUSE_UP, sendString, sendBtn)

-- Send Table
local function sendTblData(sender, event)
	if sender:hitTestPoint(event.x, event.y) then
		print("Sending Table")
		objectsToSend = {"Test 1", "Test 2", "Test 3"}
		gamekit:btSendTable(objectsToSend)
	end
end
sendTblBtn:addEventListener(Event.MOUSE_UP, sendTblData, sendTblBtn)

-- Peer Picker Cancelled
local function onPeerPickerCancelled(event)
   print("Cancelled Peer Picker")
end
gamekit:addEventListener("peerPickerCanceled", onPeerPickerCancelled)

-- Peer Connected
local function onPeerConnect(event)
	print("Connected to: "..event.peerID)
end
gamekit:addEventListener("peerConnected", onPeerConnect)

-- Recieved Data
local function onRecieveData(event)
	print("Data Recieved")
   if event.dataString ~= nil then -- If data is string
      print("Data: "..event.dataString) -- Print String
   elseif event.data ~= nil then -- else is Table
      print(event.data) --Print Table
   end
end
--Listen for Recieve Data
gamekit:addEventListener("recievedData", onRecieveData)
