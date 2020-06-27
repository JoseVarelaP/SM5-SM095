local t = Def.ActorFrame{}

t[#t+1] = LoadActor( THEME:GetPathG("","Header/Results") )..{
    OnCommand=function(self)
        self:xy(_screen.cx,_screen.cy-180):zoom(0.8):shadowlength(4)
    end
}

local JudgmentInfo = {
    Types = { 'W1', 'W2', 'W3', 'W4', 'W5', 'Miss', 'combo' },
}
local yspacing = 32
local offsetspritepos = false

if PREFSMAN:GetPreference("AllowW1") == "AllowW1_Never" then
    JudgmentInfo.Types = { 'W2', 'W3', 'W4', 'W5', 'Miss', 'combo' }
    yspacing = 36
    offsetspritepos = true
end

local ScoreInfo = Def.ActorFrame{}

for player in ivalues(PlayerNumber) do
    local Combo = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):MaxCombo()
    local grade = ToEnumShortString( STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetGrade() )
    t[#t+1] = LoadActor( THEME:GetPathG("","Grades/"..grade) )..{
        OnCommand=function(self)
            self:xy( _screen.cx+160*GAMESTATE:Side(player), _screen.cy-120 )
            :zoom(offsetspritepos and 1 or 0.8):player(player)
        end
    }
    for index,sco in ipairs(JudgmentInfo.Types) do
        t[#t+1] = Def.ActorFrame{
            OnCommand=function(self)
                self:xy( _screen.cx+160*GAMESTATE:Side(player), _screen.cy-110+(yspacing*index) )
            end,
            Def.BitmapText{
                Font="Bold Numbers",
                Text="0000",
                OnCommand=function(self)
                    self:diffuse(0.5,0.5,0.5,1):x(-30):shadowlength(3):zoom(0.8)
                    if GAMESTATE:IsPlayerEnabled(player) then
                        local scor
                        if sco == "combo" then
                            scor = Combo
                        else
                            scor = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores("TapNoteScore_"..sco)
                        end
                        self:settext(("% 4.0f"):format( scor )):diffuse(Color.White)
                    end
                end
            },

            Def.BitmapText{
                Font="Arial Bold",
                Text="0%",
                OnCommand=function(self)
                    self:shadowlength(3):zoom(0.5):x(40)
                    if GAMESTATE:IsPlayerEnabled(player) then
                        local scor, percentage = 0,0
                        if sco ~= "combo" then
                            scor = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentageOfTaps("TapNoteScore_"..sco)
                        end
                        self:settext( FormatPercentScore( scor ) )
                    end
                end
            }
        }
    end
    
    t[#t+1] = Def.BitmapText{
        Font="Bold Numbers",
        OnCommand=function(self)
            self:settextf( "% 9.0f", GAMESTATE:GetScore(player) )
            :shadowlength(3)

            if not GAMESTATE:IsPlayerEnabled(player) then
                self:settext("000000000")
                self:diffuse(0.5,0.5,0.5,1)
            end
            
            self:xy( _screen.cx+160*GAMESTATE:Side(player) , _screen.cy+160 )
        end
    }
end

for index,sco in ipairs(JudgmentInfo.Types) do
    local GhTy = THEME:GetPathG("Player judgment/Judgment","label")
    if sco == "combo" then
        GhTy = THEME:GetPathG("","Gameplay/max")
    end 
    t[#t+1] = Def.Sprite{
        Texture=GhTy,
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
        end
    }
end

t[#t+1] = Def.BitmapText{
    Font="Arial Bold",
    Text="Press NEXT",
    OnCommand=function(self)
        self:xy(_screen.cx,_screen.cy+200):zoom(0.6)
        :shadowlength(3):diffuseblink()
        SCREENMAN:GetTopScreen():GetChild("Timer"):visible(false)
    end
}

return t