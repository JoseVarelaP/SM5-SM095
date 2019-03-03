local total = Def.ActorFrame{};
local ModestoCenter = { "solo", "double" };
local pos = {
    -- P1 position
    math.floor( scale(0.80/3,0,1,SCREEN_LEFT,SCREEN_RIGHT) ),
    -- P2 position
    math.floor( scale(2.25/3,0,1,SCREEN_LEFT,SCREEN_RIGHT) )
};

total.OnCommand=function(self)
    --[[
        SM handles the background brightness by 3 quads, 2 by the sides and one in the middle.
        let's grab all of them and slowly fade them back to normal when "Here We Go" begins.

        Also don't worry about BG Videos or BG Animations breaking this method,
        those are stored in another actorframe.
    ]]
    local test = SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("")
    local BGBrightness = test:GetChild("")[5]:GetChild("BrightnessOverlay")
    for i=1,3 do
        BGBrightness[i]:diffuse(Color.Black):sleep(2):linear(0.2):diffuse(Color.White)
    end
end;

for player in ivalues(PlayerNumber) do
    local pla = pname(player)
    local posset = pos[ tonumber( string.sub(pla, -1) ) ]
    local t = Def.ActorFrame{
        OnCommand=function(self)
            self:x( posset ):player(player)
            if GAMESTATE:IsPlayerEnabled(player) then
                SCREENMAN:GetTopScreen():GetChild("Player"..pla):x( posset )
                -- check Player Judgment for info
                SCREENMAN:GetTopScreen():GetChild("Player"..pla):GetChild("Combo"):visible(false)
                SCREENMAN:GetTopScreen():GetChild("Life"..pla):visible(false)
                SCREENMAN:GetTopScreen():GetChild("Score"..pla):visible(false)
                for mode in ivalues(ModestoCenter) do
                    if GAMESTATE:GetCurrentStyle():GetName() == mode then
                        SCREENMAN:GetTopScreen():GetChild("Player"..pla):CenterX()
                        self:CenterX()
                    end
                end
            end
        end;
    };
    t[#t+1] = Def.ActorFrame{
        OnCommand=function(self) self:y( _screen.cy+200 ) end;
        -- Score information.
        -- Number fade occurs is because the frame is on top
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
        OnCommand=function(self) self:y( _screen.cy-210 ) end;
    };

    LifeFrame[#LifeFrame+1] = LoadActor( THEME:GetPathG("Gameplay/Life Meter","Frame") )..{
        OnCommand=function(self) self:Pix() end;
        LifeChangedMessageCommand=function(self,params)
            if (params.Player == player) then
                self:stopeffect()
                if params.LifeMeter:IsHot() then
                    self:diffuseshift():effectperiod(0.3):effectcolor1(0.7,0.7,0.7,1):effectcolor2(1,1,1,1) 
                end
            end
        end;
    };
    
    for i=1,17 do
        LifeFrame[#LifeFrame+1] = Def.Sprite{
            Texture=THEME:GetPathG("Gameplay/Life Meter","Pills");
            InitCommand=function(self) self:Pix():pause():setstate(i-1) end;
            OnCommand=function(self)
                self:xy( -108+(12*i),0 ):shadowlength(6)
                :bounce():effectmagnitude(0,-10,0):effectclock('beat'):effectoffset(-i/17)
                :effecttiming( 0.15, 0, 0.15, 0.2, 0.5 )
            end;
            LifeChangedMessageCommand=function(self,params)
                if (params.Player == player) then
                    local life = string.format("%.1f",params.LifeMeter:GetLife() * 10)
                    local pills = (string.format("%.1f",life * 2.9 / 17)) * 10
                    self:setstate(-1 + i)
                    :visible( pills >= i and true or false )
                end;
            end;
        };
    end

    t[#t+1] = LifeFrame;
    total[#total+1] = t;
end

for i=1,12,2 do
    total[#total+1] = Def.ActorFrame{
        OnCommand=function(self)
            self:x(20*i):y(-20+40*i)
            self:addx(-SCREEN_WIDTH):linear(1):addx(SCREEN_WIDTH*2.5)
        end;

        Def.Quad{
            OnCommand=function(self)
                self:zoomto(SCREEN_WIDTH*2.2,40):halign(0):diffuse(Color.Black)
            end;
        };
        LoadActor( THEME:GetPathG("Transition/Star","Blue") );
    };
end

for i=1,12,2 do
    total[#total+1] = Def.ActorFrame{
        OnCommand=function(self)
            self:x(20*i):y(20+40*i)
            self:addx(SCREEN_WIDTH*1.8):linear(1):addx(-SCREEN_WIDTH*2.5)
        end;

        Def.Quad{
            OnCommand=function(self)
                self:zoomto(SCREEN_WIDTH*2.2,40):halign(1):diffuse(Color.Black)
            end;
        };
        LoadActor( THEME:GetPathG("Transition/Star","Blue") )..{
            OnCommand=function(self)
                self:zoomx(-1)
            end
        };
    };
end

return total;