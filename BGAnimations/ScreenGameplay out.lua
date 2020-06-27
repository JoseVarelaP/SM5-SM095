local t = Def.ActorFrame{}

t[#t+1] = loadfile( THEME:GetPathB("","StarTransition.lua") )( false )
t[#t+1] = loadfile( THEME:GetPathB("","TextLabelTransition.lua") )( {0.3, 55, 35, "Cleared"} )

return t