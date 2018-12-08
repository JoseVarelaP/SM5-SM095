local t = Def.ActorFrame{};

t[#t+1] = LoadActor( THEME:GetPathG("","Header/Results") )..{
    OnCommand=function(self)
        self:xy(_screen.cx,_screen.cy-180):zoom(0.8):shadowlength(4)
    end;
};

local JudgmentInfo = {
    Types = { 'W1', 'W2', 'W3', 'W4', 'W5', 'Miss', 'combo' },
};
local yspacing = 32;
local offsetspritepos = false;

if PREFSMAN:GetPreference("AllowW1") == "AllowW1_Never" then
    JudgmentInfo.Types = { 'W2', 'W3', 'W4', 'W5', 'Miss', 'combo' };
    yspacing = 36;
    offsetspritepos = true;
end

local ScoreInfo = Def.ActorFrame{};

for player in ivalues(PlayerNumber) do
    local Combo = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):MaxCombo();
    local grade = ToEnumShortString( STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetGrade() );
    t[#t+1] = LoadActor( THEME:GetPathG("","Grades/"..grade) )..{
        OnCommand=function(self)
            self:xy( _screen.cx+160*GAMESTATE:Side(player), _screen.cy-120 )
            :zoom(0.8):player(player)
            if offsetspritepos then
                self:zoom(1)
            end
        end;
    };
    for index,sco in ipairs(JudgmentInfo.Types) do
        t[#t+1] = Def.ActorFrame{
            OnCommand=function(self)
                self:xy( _screen.cx+160*GAMESTATE:Side(player), _screen.cy-110+(yspacing*index) )
            end;
            Def.BitmapText{
                Font="Bold Numbers";
                OnCommand=function(self)
                    local scor;
                    if sco == "combo" then
                        scor = Combo
                    else
                        scor = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_"..sco)
                    end
                    self:settext(("% 4.0f"):format( scor ))
                    :shadowlength(3):zoom(0.8)

                    if not GAMESTATE:IsPlayerEnabled(player) then
                        self:settext("0000")
                        self:diffuse(0.5,0.5,0.5,1)
                    end
                    
                    self:xy(-30,0)
                end;
            };

            Def.BitmapText{
                Font="Arial Bold";
                OnCommand=function(self)
                    local scor, percentage = 0,0;
                    if sco == "combo" then
                        scor = 0
                    else
                        scor = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentageOfTaps("TapNoteScore_"..sco)
                    end
                    self:settext( FormatPercentScore( scor ) )
                    :shadowlength(3):zoom(0.5)

                    if not GAMESTATE:IsPlayerEnabled(player) then
                        self:settext("0%")
                    end
                    
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

            if not GAMESTATE:IsPlayerEnabled(player) then
                self:settext("000000000")
                self:diffuse(0.5,0.5,0.5,1)
            end
            
            self:xy( _screen.cx+160*GAMESTATE:Side(player) , _screen.cy+160 )
        end;
    };
end

for index,sco in ipairs(JudgmentInfo.Types) do
    local GhTy = THEME:GetPathG("Player judgment/Judgment","label")
    if sco == "combo" then
        GhTy = THEME:GetPathG("","Gameplay/max");
    end 
    t[#t+1] = Def.Sprite{
        Texture=GhTy;
        OnCommand=function(self)
            local function spritedelay(val)
                if val then
                    if offsetspritepos then
                        return val
                    end
                    return val-1
                end
            end
            self:pause()
            if sco ~= "combo" then
                self:setstate( spritedelay(index) )
            end
            self:zoom(0.8):shadowlength(3)
            self:xy( _screen.cx, _screen.cy-108+(yspacing*index) )
        end;
    };
end

t[#t+1] = Def.BitmapText{
    Font="Arial Bold";
    Text="Press NEXT";
    OnCommand=function(self)
        self:xy(_screen.cx,_screen.cy+200):zoom(0.6)
        :shadowlength(3):diffuseblink()
        SCREENMAN:GetTopScreen():GetChild("Timer"):visible(false)
    end
};

return t;