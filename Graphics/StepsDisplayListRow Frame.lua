local DifficultyToState = {
	Beginner = 0,
	Easy = 1,
	Medium = 2,
	Hard = 3,
	Challenge = 4,
	Edit = 7,
}

local t = Def.ActorFrame{};

local function Side(pn)
	if pn == 1 then return -1 end
	return 1
end

for i=1,2 do
	t[#t+1] = Def.ActorFrame{
		OnCommand=function(self)
			self:x( 170*Side(i) )
		end;
		Def.Sprite{
			Texture="Select Song/Steps Description";
			OnCommand=function(self)
				self:pause():shadowlength(3)
			end;
			SetMessageCommand=function(self,param)
				self:diffuse( 0.6,0.6,0.6,1 )
				local diff = param.CustomDifficulty
				if diff then self:setstate( DifficultyToState[diff] ) end

				if GAMESTATE:IsPlayerEnabled(i-1) and GAMESTATE:GetCurrentSteps( i-1 ) then
					local pdiff = ToEnumShortString( GAMESTATE:GetCurrentSteps(i-1):GetDifficulty() )
					self:diffuse(Color.White):stopeffect()
					if pdiff == diff then
						self:glowshift()
					end
				end
			end;
		};
	};
end

return t;