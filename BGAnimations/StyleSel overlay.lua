-- Begin by the actorframe
local t = Def.ActorFrame{}
local MenuIndex = 1
local modes = { "single", "solo", "versus", "double" }

local PadChoices = {
    Def.ActorFrame{
        LoadActor( THEME:GetPathG("Style Select/Flat","Stage") )..{
            OnCommand=function(self) self:pause() end
        },
        LoadActor( THEME:GetPathG("Style Select/player animation","male") )..{
            OnCommand=function(self) self:SetAllStateDelays(0.06):zoom(2):xy(10,-50) end
        }
    },
    Def.ActorFrame{
        LoadActor( THEME:GetPathG("Style Select/Flat","Stage") )..{
            OnCommand=function(self) self:pause() end
        },
        LoadActor( THEME:GetPathG("Style Select/player animation","male") )..{
            OnCommand=function(self) self:SetAllStateDelays(0.06):zoom(2):xy(10,-50) end
        }
    },
    Def.ActorFrame{
        LoadActor( THEME:GetPathG("Style Select/Flat","Stage") )..{
            OnCommand=function(self) self:pause():x(-65) end
        },
        LoadActor( THEME:GetPathG("Style Select/player animation","male") )..{
            OnCommand=function(self) self:SetAllStateDelays(0.06):zoom(2):xy(-50,-50) end
        },
        LoadActor( THEME:GetPathG("Style Select/Flat","Stage") )..{
            OnCommand=function(self) self:pause():setstate(1):x(65) end
        },
        LoadActor( THEME:GetPathG("Style Select/player animation","female") )..{
            OnCommand=function(self) self:SetAllStateDelays(0.06):zoom(2):xy(50,-50) end
        }
    },
    Def.ActorFrame{
        LoadActor( THEME:GetPathG("Style Select/Flat","Stage") )..{
            OnCommand=function(self) self:pause():x(-62) end
        },
        LoadActor( THEME:GetPathG("Style Select/Flat","Stage") )..{
            OnCommand=function(self) self:pause():setstate(1):x(62) end
        },
        LoadActor( THEME:GetPathG("Style Select/player animation","male") )..{
            OnCommand=function(self) self:SetAllStateDelays(0.06):zoom(2):y(-50) end
        }
    }
}

local function CheckValueOffsets(offset)
    MenuIndex = MenuIndex + offset
    if MenuIndex > #modes then MenuIndex = #modes return end
    if MenuIndex < 1 then MenuIndex = 1 return end
    SOUND:PlayOnce( THEME:GetPathS("Common","change") )
    MESSAGEMAN:Broadcast("MenuUpAllVal")
    return
end

local BTInput = {
    -- This will control the menu
    ["MenuRight"] = function() CheckValueOffsets(1) end,
    ["MenuLeft"] = function() CheckValueOffsets(-1) end,
    ["Start"] = function(event)
        if MenuIndex == 3 then
            GAMESTATE:JoinPlayer(PLAYER_1)
            GAMESTATE:JoinPlayer(PLAYER_2)
        end
        GAMESTATE:SetCurrentStyle( modes[MenuIndex] )
        SCREENMAN:NScreen("SM_Caution")
    end,
    ["Back"] = function(event)
        SCREENMAN:PlayCancelSound()
        SCREENMAN:GetTopScreen():SetPrevScreenName("SM_TitleMenu"):Cancel()
    end,
}

-- Actorframe that holds the items that the ActorScroller will handle.
local function MainMenuChoices()
    local t=Def.ActorFrame{}

    -- This will be out choices 
    for index,mch in ipairs( modes ) do
        t[#t+1] = Def.ActorFrame{
            OnCommand=function(self)
                self:xy( _screen.cx-320+(126*index), _screen.cy+140 )
            end,
            Def.Sprite{
                Texture=THEME:GetPathG("Style","Select/GameModes"),
                OnCommand=function(self)
                    self:pause():setstate(index-1):shadowlength(1)
                end,
                MenuUpAllValMessageCommand=function(self)
                    self:finishtweening()
                    :stopeffect():linear(0.2)
                    :y( MenuIndex == index and -30 or 0 )
                    if MenuIndex == index then
                        self:wag():effectperiod(2):effectmagnitude(0,0,10)
                    end
                end
            }
        }

        -- add the choice actorframes
        t[#t+1] = PadChoices[index]..{
            OnCommand=function(self) self:xy(_screen.cx,_screen.cy-20) end,
            MenuUpAllValMessageCommand=function(self)
                self:visible( MenuIndex == index )
            end
        }
    end

    return t
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

t[#t+1] = LoadActor( THEME:GetPathG("","Header/SelectGameMode") )..{
    OnCommand=function(self)
        self:xy(_screen.cx,_screen.cy-180):shadowlength(3)
    end
}

t[#t+1] = Def.Quad{
    OnCommand=function(self)
        self:xy(_screen.cx,_screen.cy-40):zoomto(SCREEN_WIDTH,160):diffuse( 0,0,0,0.4 )
    end
}

t[#t+1] = Def.BitmapText{
    Font="Arial Bold",
    Text="Use &LEFT; &RIGHT; to select, then press NEXT",
    OnCommand=function(self)
        self:xy(_screen.cx,_screen.cy+200):zoom(0.66)
        :shadowlength(3):diffuseblink()
    end
}

t[#t+1] = MainMenuChoices()
t.OnCommand=function(self)
    MESSAGEMAN:Broadcast("MenuUpAllVal")
    SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
end
return t