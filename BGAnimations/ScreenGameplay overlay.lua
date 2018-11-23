local t = Def.ActorFrame{};

local pos = {
    -- P1 position
    math.floor( scale(0.80/3,0,1,SCREEN_LEFT,SCREEN_RIGHT) ),
    -- P2 position
    math.floor( scale(2.25/3,0,1,SCREEN_LEFT,SCREEN_RIGHT) )
};

for player in ivalues(PlayerNumber) do
    local pla = pname(player)
    local posset = pos[ tonumber( string.sub(pla, -1) ) ]
    t[#t+1] = Def.ActorFrame{
        OnCommand=function(self)
            self:xy( posset, _screen.cy+200 ):player(player)
            if GAMESTATE:IsPlayerEnabled(player) then
                SCREENMAN:GetTopScreen():GetChild("Player"..pla):x( posset )
                SCREENMAN:GetTopScreen():GetChild("Life"..pla):visible(false)
                SCREENMAN:GetTopScreen():GetChild("Score"..pla):visible(false)
            end
        end;

        -- Score information.
        -- Number fade is because the frame is on top
        Def.BitmapText{
            Font="Bold Numbers";
            OnCommand=function(self) self:y(-2):shadowlength(3) end;
            ScoreChangedMessageCommand=function(self,params)
                self:settextf( "% 9.0f",GAMESTATE:GetScore(player) )
            end;
        };
        LoadActor( THEME:GetPathG("Gameplay/Score","Frame") )..{
            OnCommand=function(self) self:shadowlength(3) end;
        };
    };

    local LifeFrame = Def.ActorFrame{
        OnCommand=function(self)
            self:xy( posset, _screen.cy-210 ):player(player)
        end;
    };

    LifeFrame[#LifeFrame+1] = LoadActor( THEME:GetPathG("Gameplay/Life Meter","Frame") )..{
        OnCommand=function(self) self:Pix() end
    };
    
    for i=1,17 do
        LifeFrame[#LifeFrame+1] = Def.Sprite{
            Texture=THEME:GetPathG("Gameplay/Life Meter","Pills");
            InitCommand=function(self) self:Pix():pause():setstate(i-1) end;
            OnCommand=function(self)
                self:xy( -108+(12*i),0 ):shadowlength(6)
                self:sleep(i / 20)
                self:queuecommand("Anim")
            end;
            AnimCommand=function(self)
                self:hurrytweening(0.05)

                self:sleep( ( (GAMESTATE:GetSongBPS()/4) /GAMESTATE:GetSongBPS()) )
                self:accelerate(0.2/GAMESTATE:GetSongBPS())
                self:addy(-8)
                self:sleep(0.066/GAMESTATE:GetSongBPS())
                self:accelerate(0.2/GAMESTATE:GetSongBPS())
                self:addy(8)
                self:queuecommand("Anim")
            end;
            LifeChangedMessageCommand=function(self,params)
				if (params.Player == player) then
					local life = string.format("%.1f",params.LifeMeter:GetLife() * 10)
					local pills = (string.format("%.1f",life * 2.9 / 17)) * 10
                    self:setstate(-1 + i)
                    :visible( pills >= i and true or false )
                    :stopeffect()
                    if params.LifeMeter:IsHot() then
                        self:glowshift():effectperiod(0.1):effectcolor1(1,1,1,0.4):effectcolor2(1,1,1,0) 
                    end
				end;
			end;
        };
    end

    t[#t+1] = LifeFrame;
end

return t;

-- local PillDone = {};
-- for i=1,17 do    
--     PillDone[i] = false;
-- end
-- local function AllPillsDone()
--     local AllTotal = 0
--     print("AllTotal "..AllTotal)
--     for i=1,17 do
--         if PillDone[i] then
--             AllTotal = AllTotal + 1
--         end
--     end
--     print("AllTotal "..AllTotal)
--     return AllTotal == 17
-- end

-- BeginCommand=function(self) self:sleep(i/20):queuecommand("BounceNow") end;
-- CheckInfoCommand=function(self)
--     if AllPillsDone() then
--         PillDone[i] = false
--         self:queuecommand("BounceNow")
--     end
--     self:sleep(0.01):queuecommand("CheckInfo")
-- end;
-- BounceNowCommand=function(self)
--     local BPS = GAMESTATE:GetSongBPS()
--     self:finishtweening( 0.2/BPS )
--     self:sleep(2/BPS)
--     if not PillDone[i] then
--         PillDone[i] = true
-- 		self:accelerate(0.2/BPS)
-- 		self:addy(-8)
-- 		self:sleep(0.066/BPS)
-- 		self:accelerate(0.2/BPS)
--         self:addy(8)
--     end
--     self:queuecommand("CheckInfo")
-- end;