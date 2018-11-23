return Def.ActorFrame {
	CurrentSongChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong(); 
		if song then
-- 			self:setaux(0);
			self:finishtweening();
			self:playcommand("TweenOn");
		elseif not song and self:GetZoomX() == 1 then
-- 			self:setaux(1);
			self:finishtweening();
			self:playcommand("TweenOff");
		end;
	end;
	Def.StepsDisplayList {
		Name="StepsDisplayListRow";

		CursorP1 = Def.ActorFrame {
			InitCommand=cmd(x,-128+16;zoom,10;player,PLAYER_1);
			PlayerJoinedMessageCommand=function(self, params)
				if params.Player == PLAYER_1 then
					self:visible(true);
					(cmd(zoom,0;bounceend,1;zoom,1))(self);
				end;
			end;
			PlayerUnjoinedMessageCommand=function(self, params)
				if params.Player == PLAYER_1 then
					self:visible(true);
					(cmd(bouncebegin,1;zoom,0))(self);
				end;
			end;
			LoadActor(THEME:GetPathG("_StepsDisplayListRow","Cursor")) .. {
				InitCommand=cmd(diffuse,PlayerColor(PLAYER_1);x,8;zoom,0.75);
			};
		};
		CursorP2 = Def.ActorFrame {
			InitCommand=cmd(x,128-16;zoom,10;player,PLAYER_2);
			PlayerJoinedMessageCommand=function(self, params)
				if params.Player == PLAYER_2 then
					self:visible(true);
					(cmd(zoom,0;bounceend,1;zoom,1))(self);
				end;
			end;
			PlayerUnjoinedMessageCommand=function(self, params)
				if params.Player == PLAYER_2 then
					self:visible(true);
					(cmd(bouncebegin,1;zoom,0))(self);
				end;
			end;
			LoadActor(THEME:GetPathG("_StepsDisplayListRow","Cursor")) .. {
				InitCommand=cmd(diffuse,PlayerColor(PLAYER_2);x,-8;zoom,0.75;zoomx,-0.75;);
			};
		};
		CursorP1Frame = Def.Actor{
			ChangeCommand=cmd(stoptweening;decelerate,0.05);
		};
		CursorP2Frame = Def.Actor{
			ChangeCommand=cmd(stoptweening;decelerate,0.05);
		};
	};
};