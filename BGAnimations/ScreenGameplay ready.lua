local t = Def.ActorFrame{};

t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/Ready") )..{
    OnCommand=function(self)
        self:shadowlength(3)
        self:xy(_screen.cx+55,_screen.cy-55):diffusealpha(0):sleep(0.2):linear(0.5):Center():diffusealpha(1)
        :sleep(0.5):linear(0.5):xy(_screen.cx+55,_screen.cy-55):diffusealpha(0)
    end;
}; 
t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/Ready") )..{
    OnCommand=function(self)
        self:shadowlength(3)
        self:Center():diffusealpha(0):sleep(0.2):linear(0.5):diffusealpha(1):sleep(0.5):linear(0.5):diffusealpha(0)
    end;
}; 
t[#t+1] = LoadActor( THEME:GetPathG("","Gameplay/Ready") )..{
    OnCommand=function(self)
        self:shadowlength(3)
        self:xy(_screen.cx-55,_screen.cy+55):diffusealpha(0):sleep(0.2):linear(0.5):Center():diffusealpha(1)
        :sleep(0.5):linear(0.5):xy(_screen.cx-55,_screen.cy+55):diffusealpha(0)
    end;
};

return t;