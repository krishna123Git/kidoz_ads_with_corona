-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local widget = require( "widget" )

local kidoz  = require( "plugin.kidoz" )

local publisherID = "YOUR_PUBLISERID_HERE"
local securityToken = "YOUR_SECURITY_TOKEN_HERE"

_H = display.contentHeight
_W = display.contentWidth

-- We recommend hiding the status bar so our
-- full-screen videos are not obstructed
display.setStatusBar( display.HiddenStatusBar )
display.setDefault( "background", 1 )

local function handleDefaultAdPlay( event )
    if ( "ended" == event.phase ) then
		kidoz.show( "interstitial" )
    end
end
local defaultAdButton = widget.newButton {
    defaultFile = "images/sfSky.jpg",
    onRelease = handleDefaultAdPlay,
    -- While ads are caching, our buttons are disabled
    -- and inform the user to please wait
    label = "Please wait..",
    labelColor = { default={ 255, 255, 255, 1.0 }, over={ 0, 0, 0, 0.5 } },
    fontSize = 36,
    isEnabled = false,
    x = _W / 2,
    y = _H / 6 + 35
}
defaultAdButton:setLabel( "Please wait..." )
defaultAdButton:setEnabled( false )



local function adListener( event )
 
    if ( event.phase == "init" ) then  -- Successful initialization
        print( event.provider )
		kidoz.load( "interstitial" )
	elseif( event.phase == "loaded" ) then
		defaultAdButton:setLabel( "Play Default Ad" )
        defaultAdButton:setEnabled( true )
	elseif( event.phase == "closed" ) then
		print("pre load ads")
		kidoz.load( "interstitial" )
    end
end
 
-- Initialize the KIDOZ plugin
kidoz.init( adListener, { publisherID=publisherID, securityToken=securityToken } )
