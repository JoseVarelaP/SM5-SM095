local t = Def.ActorFrame{};

t[#t+1] = LoadActor( THEME:GetPathG("","Header/Results") )..{
    OnCommand=function(self)
        self:xy(_screen.cx,_screen.cy-180):zoom(0.8):shadowlength(4)
    end;
};

local JudgmentInfo = {
    Types = { 'W1', 'W2', 'W3', 'W4', 'W5', 'Miss' },
};

local ScoreInfo = Def.ActorFrame{};

local yspacing = 32;

for player in ivalues(PlayerNumber) do
    for index,sco in ipairs(JudgmentInfo.Types) do
        t[#t+1] = Def.ActorFrame{
            OnCommand=function(self)
                self:xy( _screen.cx+160*GAMESTATE:Side(player), _screen.cy-110+(yspacing*index) )
            end;
            Def.BitmapText{
                Font="Bold Numbers";
                OnCommand=function(self)
                    local sco = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_"..sco)
                    self:settext(("% 4.0f"):format( sco ))
                    :shadowlength(3):zoom(0.8)
                    
                    self:xy(-30,0)
                end;
            };

            Def.BitmapText{
                Font="Arial Bold";
                OnCommand=function(self)
                    local sco = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentageOfTaps("TapNoteScore_"..sco)
                    self:settext( FormatPercentScore(sco) )
                    :shadowlength(3):zoom(0.5)
                    
                    self:xy(40,0)
                end;
            };
        };
    end
    
    t[#t+1] = Def.BitmapText{
        Font="Bold Numbers";
        OnCommand=function(self)
            self:settextf( "% 9.0f", GAMESTATE:GetScore(player) )
            :shadowlength(3)
            
            self:xy( _screen.cx+160*GAMESTATE:Side(player) , _screen.cy+160 )
        end;
    };
end

for index,sco in ipairs(JudgmentInfo.Types) do
    t[#t+1] = Def.Sprite{
        Texture=THEME:GetPathG("Player judgment/Judgment","label");
        OnCommand=function(self)
            self:pause():setstate(index-1):zoom(0.8):shadowlength(3)
            self:xy( _screen.cx, _screen.cy-108+(yspacing*index) )
        end;
    };
end

return t;