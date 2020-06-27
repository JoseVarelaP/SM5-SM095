local Invert = ...
local t = Def.ActorFrame{}

local texname = Invert and "Blue" or "Yellow"
for i=1,12,2 do
    t[#t+1] = Def.ActorFrame{
        OnCommand=function(self)
            self:x(20*i):y(-20+40*i)
            if Invert then
                self:addx(-SCREEN_WIDTH):linear(1):addx(SCREEN_WIDTH*2.5)
            else
                self:addx(SCREEN_WIDTH*1.5):linear(1.2):addx(-SCREEN_WIDTH*2.5)
            end
        end,

        Def.Quad{
            OnCommand=function(self)
                self:zoomto(SCREEN_WIDTH*2.2,40):halign(0):diffuse(Color.Black)
            end,
        },
        LoadActor( THEME:GetPathG("Transition/Star",texname) )
    }
    t[#t+1] = Def.ActorFrame{
        OnCommand=function(self)
            self:x(20*i):y(20+40*i)
            if Invert then
                self:addx(SCREEN_WIDTH*1.8):linear(1):addx(-SCREEN_WIDTH*2.5)
            else
                self:addx(-SCREEN_WIDTH):linear(1):addx(SCREEN_WIDTH*2.5)
            end
        end,

        Def.Quad{
            OnCommand=function(self)
                self:zoomto(SCREEN_WIDTH*2.2,40):halign(1):diffuse(Color.Black)
            end
        },
        LoadActor( THEME:GetPathG("Transition/Star",texname) )..{
            OnCommand=function(self) self:zoomx(-1) end
        }
    }
end

return t