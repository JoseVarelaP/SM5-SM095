-- Main menu replacement

--[[
    The original main menu (ScreenTitleMenu) is honestly a mess, and can be improved by
    creating a lua variant that allows for all kinds of customization options.
]]

-- Begin by the actorframe
local t = Def.ActorFrame{};
local MenuIndex = 1;

local MenuChoices = {
    {
        "Game Start",
        function(event)
            GAMESTATE:JoinPlayer(event)
            SCREENMAN:NScreen( "StyleSel" )
        end,
    },
    {
        "Configure Pads",
        function() SCREENMAN:NScreen( "ScreenMapControllers" ) end,
    },
    {
        "Game Options",
        function(event)
            SCREENMAN:NScreen( "ScreenOptionsService" )
        end,
    },
    {
        "Check For Update",
        function()
            GAMESTATE:ApplyGameCommand("urlnoexit,http://www.stepmania.com")
        end,
    },
    {
        "Exit",
        function() SCREENMAN:NScreen( "ScreenExit" ) end,
    },
};

local BTInput = {
    -- This will control the menu
    ["MenuDown"] = function() MenuIndex = MenuIndex + 1 end,
    ["MenuUp"] = function() MenuIndex = MenuIndex - 1 end,
    ["Start"] = function(event)
        MenuChoices[MenuIndex][2](event)
    end
};    
local function CheckValueOffsets()
    if MenuIndex > #MenuChoices then MenuIndex = #MenuChoices return end
    if MenuIndex < 1 then MenuIndex = 1 return end
    MESSAGEMAN:Broadcast("MenuUpAllVal")
end

local ItemPlacement,Spacing = _screen.cy-20,36
-- Actorframe that holds the items that the ActorScroller will handle.
local function MainMenuChoices()
    local t=Def.ActorFrame{};

    -- This one will be the arrow selector
    t[#t+1] = LoadActor( THEME:GetPathG("","Color Arrow") )..{
        OnCommand=function(self)
            self:xy( _screen.cx-170, ItemPlacement+(Spacing*MenuIndex) ):zoomx(-1)
        end;
        MenuUpAllValMessageCommand=function(self)
            self:stoptweening():linear(0.05)
            self:y( ItemPlacement+(Spacing*MenuIndex) )
        end;
    };

    -- This will be out choices 
    for index,mch in ipairs( MenuChoices ) do
        t[#t+1] = Def.ActorFrame{
            OnCommand=function(self)
                self:xy( _screen.cx, ItemPlacement+(Spacing*index) )
            end;
            Def.BitmapText{
                Font="ABlO", Text=string.upper(mch[1]);
                OnCommand=function(self)
                    self:shadowlength(3)
                end;
            };
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
        if BTInput[event.GameButton] then BTInput[event.GameButton](event.PlayerNumber) end
    end    
    CheckValueOffsets()
end

local Controller = Def.ActorFrame{
    OnCommand=function(self)
    MESSAGEMAN:Broadcast("MenuUpAllVal")
    SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
    for player in ivalues(PlayerNumber) do
        GAMESTATE:UnjoinPlayer(player)
    end
end;
};

t[#t+1] = LoadActor( THEME:GetPathV("","title screen bg") )..{
    OnCommand=function(self) self:FullScreen() end
};

t[#t+1] = LoadActor( THEME:GetPathG("","Logo/Logo.png") )..{
    OnCommand=function(self) self:CenterX():y(_screen.cy-130) end;
};

t[#t+1] = LoadActor( THEME:GetPathG("","Logo/Max.png") )..{
    OnCommand=function(self)
        self:xy(_screen.cx+140,_screen.cy-25):glowshift():effectperiod(2)
        :zoomx(3):zoomy(0):sleep(0.5):linear(0.5):zoom(1)
    end
};

t[#t+1] = Def.BitmapText{
    Font="black wolf";
    Text="v0.95";
    OnCommand=function(self)
        self:xy(_screen.cx+245,_screen.cy+210)
        :diffuse(0.8,0.8,0.8,1):shadowlength(3)
    end
};

t[#t+1] = Def.BitmapText{
    Font="Arial Bold";
    Text="Use &UP; &DOWN; to select, then press NEXT";
    OnCommand=function(self)
        self:xy(_screen.cx,_screen.cy+200):zoom(0.7)
        :shadowlength(3):diffuseblink()
    end
};

SOUND:PlayAnnouncer("title menu game name")

t[#t+1] = MainMenuChoices()
t[#t+1] = Controller;

return t;