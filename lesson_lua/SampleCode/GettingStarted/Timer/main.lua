-- Abstract: Timer sample app, also demonstrating a table listener
-- 
-- Author: Corona Labs
--
-- Demonstrates: 
-- 		Demonstrates use of the timer.performWithDelay,
--		timer.pause, timer.resume, timer.cancel
--
-- File dependencies: none
--
-- Target devices: Simulator, iOS and Android
--
-- Limitations: None
--
-- Update History:
--	v1.1		7/26/2011	Working version
--	v1.2		11/28/2011	Added timer.pause, timer.resume, and timer.cancel (build 594)
--
-- Comments: 
--
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
---------------------------------------------------------------------------------------

local widget = require( "widget" )

local timeDelay = 500		-- Timer value

local button1, button2, timerID	-- forward references

local runMode = true	-- for Pause/Resume button state
local started = true
local text = ""

local background = display.newImage( "color_blur.png" )

------------------------------------------------------------
-- printd( msg )
--
-- Displays msg on display and advances display pointer
------------------------------------------------------------

local dY = 20	-- starting location

function printd( msg )
		print( "printd -> " .. msg )
        display.newText(msg == nil and "nil" or "    " .. msg, 10, dY, native.systemFont, 13)
        dY = dY + 20
end

-- Toggle between Pause and Resume
local buttonHandler1 = function( event )

	local result
	
	if runMode then
		button1:setLabel( "Resume" )
		runMode = false
		result = timer.pause( timerID )
		printd( "Pause: " .. result )
	else
		button1:setLabel( "Pause" )
		runMode = true
		result = timer.resume( timerID )
		printd( "Resume: " .. result )
	end
	
	if started == false then
		button1:setLabel( "Pause" )
		runMode = true
		text.text = "0"
		timerID = timer.performWithDelay( timeDelay, text, 50 )
		printd( "Resume: " .. result )
		started = true
	end
end

-- Cancel timer
local buttonHandler2 = function( event )

	local result, result1
	
	result, result1 = timer.cancel( timerID )
	button1:setLabel( "Start" )
	started = false
	text.text = "0"
	
	printd( "Cancel: " .. tostring(result) ..", " .. tostring(result1) )

end

button1 = widget.newButton{
	default = "buttonBlue_100.png",
	over = "buttonBlueOver_100.png",
	onRelease = buttonHandler1,
	id = "button1",
	label = "Pause",
--	font = "MarkerFelt-Thin",
	font = native.systemFontBold,
	fontSize = 22,
	emboss = true
}

button2 = widget.newButton{
	default = "buttonBlue_100.png",
	over = "buttonBlueOver_100.png",
	onRelease = buttonHandler2,
	id = "button2",
	label = "Cancel",
--	font = "MarkerFelt-Thin",
	font = native.systemFontBold,
	fontSize = 22,
	emboss = true
}
button1.x = display.contentCenterX; button1.y = 360
button2.x = display.contentCenterX; button2.y = 430

text = display.newText( "0", 115, 105, "ArialRoundedMTBold", 160 )
text:setTextColor( 0, 0, 0 )

function text:timer( event )
	
	local count = event.count

	print( "Table listener called " .. count .. " time(s)" )
	self.text = count

	if count >= 20 then
		timer.cancel( event.source ) -- after the 20th iteration, cancel timer
	end
end

-- Register to call t's timer method 50 times
timerID = timer.performWithDelay( timeDelay, text, 50 )

print( "timerID = " .. tostring( timerID ) )