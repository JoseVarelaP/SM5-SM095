local Player = ...
if not Player then error("ScreenEvaluation DifficultyIcon requires a Player") end

return LoadActor(THEME:GetPathG("ScreenSelectMusic","StepsDisplayList/_cursor p1"))..{
	InitCommand=cmd(pause);
	BeginCommand=cmd(playcommand,"Set");
	SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		self:visible(false)
		if song then
			-- change icon index based on difficulty
			local steps = GAMESTATE:GetCurrentSteps(Player)
			if steps then
				self:setstate(GetDifficultyIconFrame(steps:GetDifficulty()))
				self:visible(true)
			end
		end
	end;
};