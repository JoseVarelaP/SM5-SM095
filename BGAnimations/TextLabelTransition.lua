local var = ...
local SlideTime = var[1]
local SpacingX = var[2]
local SpacingY = var[3]
local sleeptime = var[5] or {0.8,1.2}
local t = Def.ActorFrame{}
t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/".. var[4] ) )..{
    OnCommand=function(self)
        self:shadowlength(3)
        self:xy(_screen.cx+SpacingX,_screen.cy-SpacingY):diffusealpha(0):sleep(sleeptime[1]):linear(SlideTime):Center():diffusealpha(1)
        :sleep(sleeptime[2]):linear(SlideTime):xy(_screen.cx+SpacingX,_screen.cy-SpacingY):diffusealpha(0)
    end
} 
t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/".. var[4] ) )..{
    OnCommand=function(self)
        self:shadowlength(3)
        self:Center():diffusealpha(0):sleep(sleeptime[1]):linear(SlideTime):diffusealpha(1):sleep(sleeptime[2]):linear(SlideTime):diffusealpha(0)
    end
} 
t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/".. var[4] ) )..{
    OnCommand=function(self)
        self:shadowlength(3)
        self:xy(_screen.cx-SpacingX,_screen.cy+SpacingY):diffusealpha(0):sleep(sleeptime[1]):linear(SlideTime):Center():diffusealpha(1)
        :sleep(sleeptime[2]):linear(SlideTime):xy(_screen.cx-SpacingX,_screen.cy+SpacingY):diffusealpha(0)
    end
}
return t