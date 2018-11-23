local CustomDifficultyToState = {
	Beginner = 0,
	Basic = 1,
	Trick = 2,
	Maniac = 3,
	SManiac = 4,
	Edit = 5,
}
local DifficultyToState = {
	Difficulty_Beginner = 0,
	Difficulty_Easy = 1,
	Difficulty_Medium = 2,
	Difficulty_Hard = 3,
	Difficulty_Challenge = 4,
	Difficulty_Edit = 5,
}

return Def.ActorFrame {
	Def.ActorFrame {
		InitCommand=cmd(x,-45;y,145;zoom,1.1);
		LoadActor("_4th Difficulty")..{
			InitCommand=cmd(animate,false);
			OnCommand=cmd(zoom,1);
		};
	};
};