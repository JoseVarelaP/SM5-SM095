local c;
local player = Var "Player";

local JudgeCmds = {
	TapNoteScore_W1 = cmd(zoom,1.4;linear,0.15;zoom,1);
	TapNoteScore_W2 = cmd(zoom,1.4;linear,0.15;zoom,1);
	TapNoteScore_W3 = cmd(zoom,1.4;linear,0.15;zoom,1);
	TapNoteScore_W4 = cmd(zoom,1.4;linear,0.15;zoom,1);
	TapNoteScore_W5 = cmd(zoom,1.4;linear,0.15;zoom,1);
	TapNoteScore_Miss = cmd(zoom,1.4;linear,0.15;zoom,1);
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
	LoadActor("Judgment label") .. {
		Name="Judgment";
		InitCommand=function(self)
			self:pause():visible(false)
		end;
		OnCommand=THEME:GetMetric("Judgment","JudgmentOnCommand");
		ResetCommand=function(self)
			self:finishtweening():visible(false)
		end;
	};
	
	InitCommand = function(self)
		c = self:GetChildren();
	end;

	JudgmentMessageCommand=function(self, param)
		if param.Player ~= player then return end;
		if param.HoldNoteScore then return end;

		local iNumStates = c.Judgment:GetNumStates();
		local iFrame = TNSFrames[param.TapNoteScore];
		
		local iTapNoteOffset = param.TapNoteOffset;
		
		if not iFrame then return end
		
		self:playcommand("Reset");

		c.Judgment:visible( true );
		c.Judgment:setstate( iFrame );
		JudgeCmds[param.TapNoteScore](c.Judgment);
		
	end;
};


return t;
