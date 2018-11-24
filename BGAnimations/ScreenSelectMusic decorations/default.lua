local t = Def.ActorFrame {};

local function GetDifListX(self,pn,offset,fade)
	if pn==PLAYER_1 then
		self:x(SCREEN_CENTER_X);
		if fade>0 then
			self:faderight(fade);
		end;
	end;
	return r;
end;

local function DrawDifList(pn,diff)
	local t=Def.ActorFrame {
		InitCommand=cmd(player,pn;y,SCREEN_CENTER_Y-52);
		OnCommand=cmd();
		LoadFont("Arial Bold")..{
			InitCommand=cmd(zoom,0.6;shadowlength,3);
			SetCommand=function(self)
			local st=GAMESTATE:GetCurrentStyle():GetStepsType();
			local song=GAMESTATE:GetCurrentSong();
			local course = GAMESTATE:GetCurrentCourse();
				if song then
					GetDifListX(self,pn,110,0);
					if song:HasStepsTypeAndDifficulty(st,diff) then
					local steps = song:GetOneSteps( st, diff );
						self:settext(steps:GetMeter());
					else
						self:settext("");
					end;
				else
					self:settext("");
				end;
			end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		};
	};
	return t;
end;

t[#t+1] = Def.ActorFrame{
	Def.Quad{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+106;zoomto,SCREEN_WIDTH,198;diffusecolor,Color.Black;draworder,1;diffusealpha,0.3);
	};
	LoadActor("frame")..{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-120;zoomtowidth,SCREEN_WIDTH);
	};
	LoadActor("difftab")..{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-50);
	};
	DrawDifList(PLAYER_1,'Difficulty_Easy')..{
		OnCommand=cmd(halign,0;addx,-28;);
	};
	DrawDifList(PLAYER_1,'Difficulty_Medium')..{
		OnCommand=cmd(halign,0;addx,8;);
	};
	DrawDifList(PLAYER_1,'Difficulty_Hard')..{
		OnCommand=cmd(halign,0;addx,48;);
	};
	LoadActor("cursor")..{
		OnCommand=cmd(x,SCREEN_CENTER_X-245;y,SCREEN_CENTER_Y-140;zoomy,.5);
	};
	LoadActor("cursor")..{
		OnCommand=cmd(x,SCREEN_CENTER_X+245;y,SCREEN_CENTER_Y-140;zoomy,.5;zoomx,-1);
	};
	LoadActor("Banner")..{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-120);
	};
	Def.BPMDisplay {
		File=THEME:GetPathF("BPMDisplay", "bpm");
		Name="BPMDisplay";
		InitCommand=cmd(x,SCREEN_CENTER_X+236;y,SCREEN_CENTER_Y-90;horizalign,right;shadowlength,4;zoom,.704);
		OffCommand=cmd(diffusealpha,0);
		SetCommand=function(self) self:SetFromGameState() end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	};
	LoadActor("_bpm label") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X+267;y,SCREEN_CENTER_Y-77);
		OffCommand=cmd(diffusealpha,0);
		CurrentSongChangedMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			self:stoptweening():linear(0.5):diffuse(Color.White)
			if song:HasSignificantBPMChangesOrStops() and not song:IsDisplayBpmConstant() then
				self:diffusetopedge( color("#fb0000") )
				:diffusebottomedge( color("#9d0000") )
			end
		end;
	};
	LoadFont("ABlO")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-290;y,SCREEN_CENTER_Y-106;horizalign,left;zoom,.736;diffuseshift;effectcolor1,1,1,1,1;effectcolor2,.5,.5,.5,1;effectperiod,2;shadowlength,4);
		SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong();
			if song then
				self:settext("Group:"..song:GetGroupName());
			else
				self:settext("Group:");
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	};
	LoadFont("ABlO")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-290;y,SCREEN_CENTER_Y-76;horizalign,left;zoom,.736;diffuseshift;effectcolor1,1,1,1,1;effectcolor2,.5,.5,.5,1;effectperiod,2;shadowlength,4);
		SetCommand=function(self)
			local so = GAMESTATE:GetSortOrder();
			if so ~= nil then
				self:settext("Order:"..SortOrderToLocalizedString(so));
			else
				self:settext("Order:");
			end;
		end;
		SortOrderChangedMessageCommand=cmd(playcommand,"Set");
	};
	LoadActor("header")..{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-190;shadowlength,4);
		StartSelectingStepsMessageCommand=cmd(linear,0.5;diffusealpha,0);
		SongUnchosenMessageCommand=cmd(stoptweening;linear,0.5;diffusealpha,1);
	};
	LoadActor("steps")..{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-190;shadowlength,4;diffusealpha,0);
		StartSelectingStepsMessageCommand=cmd(sleep,0.5;diffusealpha,1);
		SongUnchosenMessageCommand=cmd(stoptweening;diffusealpha,0);
	};

	LoadFont("ABlO")..{
		OnCommand=function(self)
			self:xy( SCREEN_CENTER_X,SCREEN_CENTER_Y-20 ):zoom(0.8):shadowlength(3)
		end;
		CurrentSongChangedMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			self:settext("")
			if song then
				self:settext( song:GetDisplayMainTitle() )
			end
		end;
	};
};

t[#t+1] = Def.BitmapText{
    Font="Arial Bold";
    Text="&LEFT; &RIGHT; switch song     &UP; &DOWN; diferent group    &MENUUP; &MENUDOWN; different sort";
    OnCommand=function(self)
        self:xy(_screen.cx,_screen.cy+200):zoom(0.7)
        :shadowlength(3):diffuseblink()
	end;
	StartSelectingStepsMessageCommand=function(self)
		self:stoptweening():sleep(0.5):diffusealpha(0)
	end;
	SongUnchosenMessageCommand=function(self)
		self:stoptweening():diffusealpha(1)
	end;
};

t[#t+1] = Def.BitmapText{
    Font="Arial Bold";
    Text="User &UP; &DOWN; to change. Hold NEXT for Options menu.";
    OnCommand=function(self)
        self:xy(_screen.cx,_screen.cy+200):zoom(0.7)
        :shadowlength(3):diffuseblink():diffusealpha(0)
	end;
	StartSelectingStepsMessageCommand=function(self)
		self:stoptweening():sleep(0.5):diffusealpha(1)
	end;
	SongUnchosenMessageCommand=function(self)
		self:stoptweening():diffusealpha(0)
	end;
};

return t;