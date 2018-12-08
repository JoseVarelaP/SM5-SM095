local t = Def.ActorFrame {
	InitCommand=function(self) c = self:GetChildren(); end;
	--Banner
	Def.Sprite{
		Name="SBanner";
		InitCommand=cmd(setsize,320,120);
	};
	SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong();
		local Path = THEME:GetPathG("Common","fallback banner");
		c.SBanner:diffusealpha(0);
		if song then
			Path = song:GetBannerPath();
			if not Path then
				Path = THEME:GetPathG("Common","fallback banner");
			end
			c.SBanner:LoadBanner(Path);
			c.SBanner:diffusealpha(1);
		end;
		c.SBanner:setsize(320,120);
	end;
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
};

return t;