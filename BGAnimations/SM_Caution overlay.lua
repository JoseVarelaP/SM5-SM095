local t = Def.ActorFrame{};

t[#t+1] = Def.Quad{
    OnCommand=function(self)
        self:FullScreen():diffuse(Color.Black)
    end;
};

t[#t+1] = Def.Sprite{
    Texture=THEME:GetPathG("","Warning/caution");
    OnCommand=function(self)
        self:Center():zoom(0.8)
    end;
};

t[#t+1] = LoadFont("ABlO")..{
    Text="EXTREME MOTIONS ARE DANGEROUS\n\nBE CAREFULL NOT TO SLIP AND FALL\n\nAND NOT TO ANNOY OTHERS\n\nWITH STEP VIBRATIONS";
    OnCommand=function(self)
        self:Center()
    end;
};

t.BeginCommand=function(self)
	SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectMusic"):sleep(2):queuecommand("Continue")
end;
t.ContinueCommand=function(self)
    SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
end;

return t;