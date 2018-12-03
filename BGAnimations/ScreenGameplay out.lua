local t = Def.ActorFrame{};

local SlideTime = 0.3
local SpacingX,SpacingY = 55,35

for i=1,12,2 do
    t[#t+1] = Def.ActorFrame{
        OnCommand=function(self)
            self:x(20*i):y(-20+40*i)
            self:addx(SCREEN_WIDTH*1.5):linear(1.2):addx(-SCREEN_WIDTH*2.5)
        end;

        Def.Quad{
            OnCommand=function(self)
                self:zoomto(SCREEN_WIDTH*2.2,40):halign(0):diffuse(Color.Black)
            end;
        };
        LoadActor( THEME:GetPathG("Transition/Star","Yellow") );
    };
end

for i=1,12,2 do
    t[#t+1] = Def.ActorFrame{
        OnCommand=function(self)
            self:x(20*i):y(20+40*i)
            self:addx(-SCREEN_WIDTH):linear(1):addx(SCREEN_WIDTH*2.5)
        end;

        Def.Quad{
            OnCommand=function(self)
                self:zoomto(SCREEN_WIDTH*2.2,40):halign(1):diffuse(Color.Black)
            end;
        };
        LoadActor( THEME:GetPathG("Transition/Star","Yellow") )..{
            OnCommand=function(self)
                self:zoomx(-1)
            end
        };
    };
end

t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/Cleared") )..{
    OnCommand=function(self)
        self:shadowlength(3)
        self:xy(_screen.cx+SpacingX,_screen.cy-SpacingY):diffusealpha(0):sleep(0.8):linear(SlideTime):Center():diffusealpha(1)
        :sleep(1.2):linear(SlideTime):xy(_screen.cx+SpacingX,_screen.cy-SpacingY):diffusealpha(0)
    end;
}; 
t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/Cleared") )..{
    OnCommand=function(self)
        self:shadowlength(3)
        self:Center():diffusealpha(0):sleep(0.8):linear(SlideTime):diffusealpha(1):sleep(1.2):linear(SlideTime):diffusealpha(0)
    end;
}; 
t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/Cleared") )..{
    OnCommand=function(self)
        self:shadowlength(3)
        self:xy(_screen.cx-SpacingX,_screen.cy+SpacingY):diffusealpha(0):sleep(0.8):linear(SlideTime):Center():diffusealpha(1)
        :sleep(1.2):linear(SlideTime):xy(_screen.cx-SpacingX,_screen.cy+SpacingY):diffusealpha(0)
    end;
};

return t;