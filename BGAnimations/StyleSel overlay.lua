-- Begin by the actorframe
local t = Def.ActorFrame{};
local MenuIndex = 1;

local GoToWarn = function() SCREENMAN:NScreen("SM_Caution") end;

local MenuChoices = {
    {
        function()
            GAMESTATE:SetCurrentStyle("single")
            GoToWarn()
        end,
    },
    {
        function()
            GAMESTATE:SetCurrentStyle("solo")
            GoToWarn()
        end,
    },
    {
        function()
            GAMESTATE:JoinPlayer(PLAYER_1)
            GAMESTATE:JoinPlayer(PLAYER_2)
            GAMESTATE:SetCurrentStyle("versus")
            GoToWarn()
        end,
    },
    {
        function()
            GAMESTATE:SetCurrentStyle("double")
            GoToWarn()
        end,
    },
};

local PadChoices = {
    Def.ActorFrame{
        OnCommand=function(self)
            self:CenterX():y(_screen.cy-20)
        end;

        LoadActor( THEME:GetPathG("Style Select/Flat","Stage") )..{
            OnCommand=function(self)
                self:pause()
            end
        };
        
        LoadActor( THEME:GetPathG("Style Select/player animation","male") )..{
            OnCommand=function(self) self:SetAllStateDelays(0.06):zoom(2):y(-50):x(10) end
        };
    },
    Def.ActorFrame{
        OnCommand=function(self)
            self:CenterX():y(_screen.cy-20)
        end;

        LoadActor( THEME:GetPathG("Style Select/Flat","Stage") )..{
            OnCommand=function(self) self:pause() end
        };

        LoadActor( THEME:GetPathG("Style Select/player animation","male") )..{
            OnCommand=function(self) self:SetAllStateDelays(0.06):zoom(2):y(-50):x(10) end
        };
    },
    Def.ActorFrame{
        OnCommand=function(self)
            self:CenterX():y(_screen.cy-20)
        end;

        LoadActor( THEME:GetPathG("Style Select/Flat","Stage") )..{
            OnCommand=function(self) self:pause():x(-65) end
        };
        LoadActor( THEME:GetPathG("Style Select/player animation","male") )..{
            OnCommand=function(self) self:SetAllStateDelays(0.06):zoom(2):y(-50):x(-50) end
        };
        LoadActor( THEME:GetPathG("Style Select/Flat","Stage") )..{
            OnCommand=function(self) self:pause():setstate(1):x(65) end
        };
        LoadActor( THEME:GetPathG("Style Select/player animation","female") )..{
            OnCommand=function(self) self:SetAllStateDelays(0.06):zoom(2):y(-50):x(50) end
        };
    },
    Def.ActorFrame{
        OnCommand=function(self)
            self:CenterX():y(_screen.cy-20)
        end;

        LoadActor( THEME:GetPathG("Style Select/Flat","Stage") )..{
            OnCommand=function(self) self:pause():x(-62) end
        };
        LoadActor( THEME:GetPathG("Style Select/Flat","Stage") )..{
            OnCommand=function(self) self:pause():setstate(1):x(62) end
        };
        LoadActor( THEME:GetPathG("Style Select/player animation","male") )..{
            OnCommand=function(self) self:SetAllStateDelays(0.06):zoom(2):y(-50) end
        };
    },
};

local function CheckValueOffsets()
    if MenuIndex > #MenuChoices then MenuIndex = #MenuChoices return end
    if MenuIndex < 1 then MenuIndex = 1 return end
    SOUND:PlayOnce( THEME:GetPathS("Common","change") )
    MESSAGEMAN:Broadcast("MenuUpAllVal")
    return
end

local BTInput = {
    -- This will control the menu
    ["MenuRight"] = function()
        MenuIndex = MenuIndex + 1
        CheckValueOffsets()
    end,
    ["MenuLeft"] = function()
        MenuIndex = MenuIndex - 1
        CheckValueOffsets()
    end,
    ["Start"] = function(event)
        MenuChoices[MenuIndex][1](event)
    end,
    ["Back"] = function(event)
        SCREENMAN:PlayCancelSound()
        SCREENMAN:GetTopScreen():SetPrevScreenName("SM_TitleMenu"):Cancel()
    end,
};

local ItemPlacement,Spacing = _screen.cx-320,126
-- Actorframe that holds the items that the ActorScroller will handle.
local function MainMenuChoices()
    local t=Def.ActorFrame{};

    -- This will be out choices 
    for index,mch in ipairs( MenuChoices ) do
        t[#t+1] = Def.ActorFrame{
            OnCommand=function(self)
                self:xy( ItemPlacement+(Spacing*index), _screen.cy+140 )
            end;
            Def.Sprite{
                Texture=THEME:GetPathG("Style","Select/GameModes");
                OnCommand=function(self)
                    self:pause():setstate(index-1):AddWrapperState():shadowlength(1)
                end;
                MenuUpAllValMessageCommand=function(self)
                    self:finishtweening()
                    :stopeffect():linear(0.1)
                    :y( MenuIndex == index and -30 or 0 )
                    if MenuIndex == index then
                        self:wag():effectperiod(2):effectmagnitude(0,0,10)
                    end
                end;
            };
        };

        -- add the choice actorframes
        t[#t+1] = PadChoices[index]..{
            MenuUpAllValMessageCommand=function(self)
                self:visible( MenuIndex == index )
            end;
        };
    end

    return t;
end
    
local function InputHandler(event)
    -- Safe check to input nothing if any value happens to be not a player.
    -- ( AI, or engine input )
    if not event.PlayerNumber then return end
    local ET = ToEnumShortString(event.type)
    -- Input that occurs at the moment the button is pressed.
    if ET == "FirstPress" or ET == "Repeat" then
        if BTInput[event.GameButton] then
            BTInput[event.GameButton](event.PlayerNumber)
        end
    end
end

local Controller = Def.ActorFrame{
    OnCommand=function(self)
    MESSAGEMAN:Broadcast("MenuUpAllVal")
    SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end;
};

t[#t+1] = LoadActor( THEME:GetPathV("","Menu BG") )..{
    OnCommand=function(self)
        self:Center():zoomtoheight( SCREEN_HEIGHT ):zoomtowidth(SCREEN_WIDTH):diffuse( 0.8,0.8,0.8,1 )
    end
};

t[#t+1] = LoadActor( THEME:GetPathG("","Header/SelectGameMode") )..{
    OnCommand=function(self)
        self:CenterX():y(_screen.cy-180):shadowlength(3)
    end
};

t[#t+1] = Def.Quad{
    OnCommand=function(self)
        self:xy( _screen.cx,_screen.cy-40 ):zoomto(SCREEN_WIDTH,160):diffuse( 0,0,0,0.4 )
    end;
};

t[#t+1] = MainMenuChoices()
t[#t+1] = Controller;

return t;