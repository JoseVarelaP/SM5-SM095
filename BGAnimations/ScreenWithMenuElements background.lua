local t = Def.ActorFrame{};

t[#t+1] = LoadActor( THEME:GetPathV("","Menu BG") )..{
    OnCommand=function(self)
        self:Center():zoomtoheight( SCREEN_HEIGHT ):zoomtowidth(SCREEN_WIDTH):diffuse( 0.8,0.8,0.8,1 )
    end
};

return t;