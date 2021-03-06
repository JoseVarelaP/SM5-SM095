local c;
local player = Var "Player";

-- Taken straight from the src
local JUDGEMENT_DISPLAY_TIME = 0.6;

local JudgeCmds = {
	TapNoteScore_W1 = cmd(finishtweening;y,20;zoom,1.35;linear,JUDGEMENT_DISPLAY_TIME/5;zoom,1);
	TapNoteScore_W2 = cmd(finishtweening;y,20;zoom,1.35;linear,JUDGEMENT_DISPLAY_TIME/5;zoom,1);
	TapNoteScore_W3 = cmd(finishtweening;y,20;zoom,1.35;linear,JUDGEMENT_DISPLAY_TIME/5;zoom,1);
	TapNoteScore_W4 = cmd(finishtweening;y,20;zoom,1.35;linear,JUDGEMENT_DISPLAY_TIME/5;zoom,1);
	TapNoteScore_W5 = cmd(finishtweening;y,20;zoom,1.35;linear,JUDGEMENT_DISPLAY_TIME/5;zoom,1);
	TapNoteScore_Miss = cmd(finishtweening;zoom,1;y,-30;linear,JUDGEMENT_DISPLAY_TIME;y,30);
};

local TNSFrames = {
	TapNoteScore_W1 = 0;
	TapNoteScore_W2 = 1;
	TapNoteScore_W3 = 2;
	TapNoteScore_W4 = 3;
	TapNoteScore_W5 = 4;
	TapNoteScore_Miss = 5;
};

local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {

	Def.ActorFrame{
		Name="BaseJudgment";
		-- yes i did that
		LoadActor( "../Player combo" )..{
			OnCommand=function(self)
				self:y(50)
			end;
		};
		LoadActor("Judgment label") .. {
			Name="Judgment";
			InitCommand=function(self)
				self:pause():visible(false):shadowlength(6):valign(1):y(10)
			end;
			OnCommand=THEME:GetMetric("Judgment","JudgmentOnCommand");
			ResetCommand=function(self)
				self:finishtweening():visible(false)
			end;
		};
	};
	
	InitCommand = function(self)
		c = self:GetChildren();
	end;

	JudgmentMessageCommand=function(self, param)
		if param.Player ~= player then return end;
		if param.HoldNoteScore then return end;

		local JActo = self:GetChild("BaseJudgment");
		local Judgm = self:GetChild("BaseJudgment"):GetChild("Judgment");
		local iNumStates = Judgm:GetNumStates();
		local iFrame = TNSFrames[param.TapNoteScore];
		
		local iTapNoteOffset = param.TapNoteOffset;
		
		if not iFrame then return end
		
		self:playcommand("Reset");

		Judgm:visible( true );
		Judgm:setstate( iFrame );
		Judgm:diffusealpha(1);
		JudgeCmds[param.TapNoteScore](JActo);
		Judgm:sleep(0.7);
		Judgm:diffusealpha(0);
		
	end;
};


return t;
