local t = Def.ActorFrame{
	Def.Sprite {
		Name="Banner";
		InitCommand=cmd(shadowlength,5);
		SetMessageCommand=function(self,params)
			local Song = params.Song;
			if Song then
				if params.Song:HasBanner() then
					self:LoadBackground(params.Song:GetBannerPath());
					self:scaletoclipped(256,80);
				elseif params.Song:HasBackground() then
					self:LoadBackground(params.Song:GetBackgroundPath());
					self:scaletoclipped(256,80);
				else
					self:LoadBackground(THEME:GetPathG("common fallback", "banner"));
					self:scaletoclipped(256,80);
				end;
			end;
		end;
	};
};

return t;