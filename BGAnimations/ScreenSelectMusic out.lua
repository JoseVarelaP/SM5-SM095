local t = Def.ActorFrame{}

t[#t+1] = Def.Quad{
    StartTransitioningCommand=function(self)
        self:FullScreen():diffuse( 0,0,0,0 ):linear(0.5):diffusealpha(1)
    end
};

return t;