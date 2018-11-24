local t = Def.ActorFrame{};

t[#t+1] = LoadActor( THEME:GetPathG("","Header/PlayerOptions") )..{
    OnCommand=function(self)
        self:CenterX():y(_screen.cy-200):shadowlength(3)
    end
};

t[#t+1] = Def.BitmapText{
    Font="Arial Bold";
    Text="Use &UP; &DOWN; to select, &LEFT; &RIGHT; to change, then press NEXT";
    OnCommand=function(self)
        self:xy(_screen.cx,_screen.cy+200):zoom(0.65)
        :shadowlength(3):diffuseblink()
	end;
};

return t;