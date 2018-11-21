local t = Def.ActorFrame{};

t[#t+1] = Def.Sprite{
    Texture=THEME:GetPathG("","Warning/caution");
    OnCommand=function(self)
        self:Center():zoom(0.8)
    end;
};

t.BeginCommand=function(self)
	SCREENMAN:GetTopScreen():SetNextScreenName("ScreenSelectMusic"):sleep(2):queuecommand("Continue")
end;
t.ContinueCommand=function(self)
    SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
end;

return t;