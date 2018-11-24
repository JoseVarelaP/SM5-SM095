local function BannerSafeCheck(songdata)
	local ToLoad = THEME:GetPathG("common fallback", "banner")
	if songdata then
		local HasBG,HasBN = songdata:HasBackground(),songdata:HasBanner()
		if HasBN then ToLoad = songdata:GetBannerPath() return ToLoad end
		if HasBG then ToLoad = songdata:GetBackgroundPath() return ToLoad end
	end
	return ToLoad
end

local t = Def.ActorFrame{
	Def.Sprite {
		Name="Banner";
		SetMessageCommand=function(self,params)
			local Song = params.Song;
			if Song then
				self:LoadBackground( BannerSafeCheck(Song) );
				self:scaletoclipped(256,80);

				self:stopeffect()
				if GAMESTATE:GetCurrentSong() == params.Song then
					self:glowshift()
				end
			end;
		end;
	};
};

return t;