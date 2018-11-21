local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
    OnCommand=function(self)
        self:FullScreen():diffuse( Color.Black )
        :faderight(0.2):cropright(1.1):linear(0.5):cropright(0):faderight(0):sleep(0.5)
    end
};

t[#t+1] = LoadActor( THEME:GetPathG("Logo/Logo","dots") )..{
    OnCommand=function(self)
        self:Center():diffusealpha(0)
        :sleep(0.2):linear(0.5):diffusealpha(1)
    end
};

return t;