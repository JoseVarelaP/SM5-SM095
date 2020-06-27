local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
    OnCommand=function(self) self:stretchto(SCREEN_WIDTH,SCREEN_HEIGHT,0,0):diffuse(Color.Black) end
}

t[#t+1] = Def.Sprite{
    Texture=THEME:GetPathG("","Warning/caution"),
    OnCommand=function(self) self:xy( SCREEN_CENTER_X,SCREEN_CENTER_Y ):zoom(0.8) end
}

t[#t+1] = Def.BitmapText{
    Font="ABlO",
    Text="EXTREME MOTIONS ARE DANGEROUS\n\nBE CAREFULL NOT TO SLIP AND FALL\n\nAND NOT TO ANNOY OTHERS\n\nWITH STEP VIBRATIONS",
    OnCommand=function(self) self:xy( SCREEN_CENTER_X,SCREEN_CENTER_Y ) end
}

t.BeginCommand=function(self) self:sleep(2):queuecommand("Continue") end
t.ContinueCommand=function(self) SCREENMAN:NScreen("ScreenSelectMusic") end

return t