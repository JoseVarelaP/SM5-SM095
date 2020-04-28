local t = Def.ActorFrame {}

local function DrawDifList(diff)
	local t=Def.ActorFrame {
		InitCommand=function(s) s:y(SCREEN_CENTER_Y-52) end,
		CurrentSongChangedMessageCommand=function(s) s:playcommand("Set") end,
		Def.BitmapText{
			Font="Arial Bold",
			InitCommand=function(s) s:zoom(0.6):shadowlength(3) end,
			SetCommand=function(s)
			local st=GAMESTATE:GetCurrentStyle():GetStepsType()
			local song=GAMESTATE:GetCurrentSong()
			s:settext(""):x(SCREEN_CENTER_X)
				if song then
					if song:HasStepsTypeAndDifficulty( st,diff) then
						local steps = song:GetOneSteps( st, diff )
						s:settext(steps:GetMeter())
					end
				end
			end
		}
	}
	return t
end

t[#t+1] = Def.ActorFrame{
	Def.Quad{
		OnCommand=function(s) s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y+106):zoomto(SCREEN_WIDTH,198)
			:diffusecolor(Color.Black):diffusealpha(0.3) end,
	};
	LoadActor( THEME:GetPathG("Select","Song/frame") )..{
		OnCommand=function(s) s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-120):zoomtowidth(SCREEN_WIDTH) end,
	};
	LoadActor( THEME:GetPathG("Select","Song/difftab") )..{
		OnCommand=function(s) s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-50) end,
	};
	LoadActor( THEME:GetPathG("Select","Song/cursor") )..{
		OnCommand=function(s) s:xy(SCREEN_CENTER_X-245,SCREEN_CENTER_Y-140):zoomy(.5) end,
	};
	LoadActor( THEME:GetPathG("Select","Song/cursor") )..{
		OnCommand=function(s) s:xy(SCREEN_CENTER_X+245,SCREEN_CENTER_Y-140):zoomy(.5):zoomx(-1) end,
	};
	LoadActor("Banner")..{
		OnCommand=function(s) s:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-120) end,
	};
	Def.BPMDisplay {
		File=THEME:GetPathF("BPMDisplay", "bpm");
		Name="BPMDisplay";
		InitCommand=cmd(x,SCREEN_CENTER_X+236;y,SCREEN_CENTER_Y-90;horizalign,right;shadowlength,4;zoom,.704);
		OffCommand=cmd(diffusealpha,0);
		CurrentSongChangedMessageCommand=function(self) self:SetFromGameState() end;
	};
	LoadActor( THEME:GetPathG("Select","Song/_bpm label") ) .. {
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
		self:settext("Group:");
			if song then
				self:settext("Group:"..song:GetGroupName());
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	};
	LoadFont("ABlO")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-290;y,SCREEN_CENTER_Y-76;horizalign,left;zoom,.736;diffuseshift;effectcolor1,1,1,1,1;effectcolor2,.5,.5,.5,1;effectperiod,2;shadowlength,4);
		SetCommand=function(self)
			local so = GAMESTATE:GetSortOrder();
			self:settext("Order:");
			if so ~= nil then
				self:settext("Order:"..SortOrderToLocalizedString(so));
			end;
		end;
		SortOrderChangedMessageCommand=cmd(playcommand,"Set");
	};
	LoadActor( THEME:GetPathG("","Header/SelectSong") )..{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-190;shadowlength,4);
		StartSelectingStepsMessageCommand=cmd(linear,0.5;diffusealpha,0);
		SongUnchosenMessageCommand=cmd(stoptweening;linear,0.5;diffusealpha,1);
	};
	LoadActor( THEME:GetPathG("","Header/SelectSteps") )..{
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-190;shadowlength,4;diffusealpha,0);
		StartSelectingStepsMessageCommand=cmd(sleep,0.5;diffusealpha,1);
		SongUnchosenMessageCommand=cmd(stoptweening;diffusealpha,0);
	};
};

local ListDraw = {
	{-25, "Difficulty_Easy"},
	{8, "Difficulty_Medium"},
	{50, "Difficulty_Hard"},
};

for val in ivalues(ListDraw) do
	t[#t+1] = DrawDifList( val[2] )..{
		OnCommand=function(self)
			self:addx(val[1]):addy(2)
		end;
	};
end;

t[#t+1] = Def.StepsDisplayList{
	Name="StepsDisplayList";
	OnCommand=function(self)
		self:zoom(1):xy( SCREEN_CENTER_X,SCREEN_CENTER_Y+30 ):diffusealpha(0)
	end;
	StartSelectingStepsMessageCommand=function(self)
		self:stoptweening():sleep(0.5):diffusealpha(1)
	end;
	SongUnchosenMessageCommand=function(self)
		self:stoptweening():diffusealpha(0)
	end;

	CursorP1=Def.ActorFrame{};
	CursorP1Frame=Def.ActorFrame{};
	CursorP2=Def.ActorFrame{};
	CursorP2Frame=Def.ActorFrame{};
};

local textmain="&LEFT; &RIGHT; switch song     &UP; &DOWN; diferent group    &MENUUP; &MENUDOWN; different sort"
local textstep="Use &UP; &DOWN; to change. Hold NEXT for Options menu."

t[#t+1] = Def.BitmapText{
    Font="Arial Bold";
    Text=textmain;
    OnCommand=function(self)
        self:xy(_screen.cx,_screen.cy+200):zoom(0.7)
        :shadowlength(3):diffuseblink()
	end;
	StartSelectingStepsMessageCommand=function(self)
		self:stoptweening():sleep(0.5):queuecommand("ChangeText")
	end;
	ChangeTextCommand=function(self) self:settext(textstep) end;
	SongUnchosenMessageCommand=function(self)
		self:stoptweening():diffusealpha(1):settext(textmain)
	end;
};

return t;