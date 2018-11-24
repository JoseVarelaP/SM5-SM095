local t = Def.ActorFrame{};

local SlideTime = 0.3
local SpacingX,SpacingY = 55,35

t[#t+1] = LoadActor( THEME:GetPathG("Gameplay/Here We","Go") )..{
    OnCommand=function(self)
        self:shadowlength(3)
        self:xy(_screen.cx+SpacingX,_screen.cy-SpacingY):diffusealpha(0):sleep(0.2):linear(SlideTime):Center():diffusealpha(1)
        :sleep(0.4):linear(SlideTime):xy(_screen.cx+SpacingX,_screen.cy-SpacingY):diffusealpha(0)
    end;
}; 
t[#t+1] = LoadActor( THEME:GetPathG("Gameplay/Here We","Go") )..{
    OnCommand=function(self)
        self:shadowlength(3)
        self:Center():diffusealpha(0):sleep(0.2):linear(SlideTime):diffusealpha(1):sleep(0.4):linear(SlideTime):diffusealpha(0)
    end;
}; 
t[#t+1] = LoadActor( THEME:GetPathG("Gameplay/Here We","Go") )..{
    OnCommand=function(self)
        self:shadowlength(3)
        self:xy(_screen.cx-SpacingX,_screen.cy+SpacingY):diffusealpha(0):sleep(0.2):linear(SlideTime):Center():diffusealpha(1)
        :sleep(0.4):linear(SlideTime):xy(_screen.cx-SpacingX,_screen.cy+SpacingY):diffusealpha(0)
    end;
};

return t;