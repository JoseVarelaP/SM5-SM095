local t = Def.ActorFrame{}

local SlideTime = 0.3
local SpacingX,SpacingY = 55,35

t[#t+1] = loadfile( THEME:GetPathB("","StarTransition.lua") )( false )
t[#t+1] = loadfile( THEME:GetPathB("","TextLabelTransition.lua") )( {SlideTime, SpacingX, SpacingY, "Failed"} )

return t