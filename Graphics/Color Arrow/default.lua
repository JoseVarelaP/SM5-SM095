local t = Def.ActorFrame{}

t[#t+1] = Def.Sprite{
    Texture="gray part";
    OnCommand=function(self)
    
    end;
};

t[#t+1] = Def.Sprite{
    Texture="color part";
    OnCommand=function(self)
        self:rainbow()
    end;
};

return t;