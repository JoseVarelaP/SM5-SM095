local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
    OnCommand=function(self)
        self:FullScreen():diffuse( Color.Black )
        :fadeleft(0.2):cropleft(0):linear(0.5):cropleft(1.1):fadeleft(0):sleep(0.1)
    end
};

t[#t+1] = LoadActor( THEME:GetPathG("Logo/Logo","dots") )..{
    OnCommand=function(self)
        self:Center():diffusealpha(1)
        :linear(0.3):diffusealpha(0)
    end
};

return t;