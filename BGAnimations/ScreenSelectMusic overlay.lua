local t = Def.ActorFrame{}

local Items = {
    ["Hide"] = { "SectionCount","SongName" },
}

t.OnCommand=function(self)
    SCREENMAN:GetTopScreen():GetChild("Banner"):visible(false)

    local MWheel = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
    MWheel:xy( SCREEN_CENTER_X, SCREEN_CENTER_Y+109 ):draworder(1)
    -- alright we got items
    local WheelTable = MWheel:GetChild("MusicWheelItem")
    local NItems = THEME:GetMetric("MusicWheel","NumWheelItems")+2

    for i=1,NItems do
        WheelTable[i]:GetChild("SongNormalPart"):GetChild("Banner"):shadowlengthx(7)
        for sec in ivalues(Items.Hide) do
            WheelTable[i]:GetChild(sec):zoom(0)
        end
    end
    SCREENMAN:GetTopScreen():GetChild("Timer"):visible(false)
end

t.StartSelectingStepsMessageCommand=function(self)
    local MWheel = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
    MWheel:stoptweening():linear(0.4):y(SCREEN_CENTER_Y+400 )
end

local function ReloadWheelTween()
    local MWheel = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
    MWheel:stoptweening():linear(0.3):y(SCREEN_CENTER_Y+450 )
    :linear(0.3):y(SCREEN_CENTER_Y+109 )
end

t.NextGroupMessageCommand=function(self) ReloadWheelTween() end
t.PreviousGroupMessageCommand=function(self) ReloadWheelTween() end

t.SongUnchosenMessageCommand=function(self)
    local MWheel = SCREENMAN:GetTopScreen():GetChild("MusicWheel")
    MWheel:stoptweening():linear(0.3):y( SCREEN_CENTER_Y+109 )
end

t[#t+1] = LoadFont("ABlO")..{
    OnCommand=function(self)
        self:xy( SCREEN_CENTER_X,SCREEN_CENTER_Y-20 ):zoom(0.8):shadowlength(3)
    end,
    CurrentSongChangedMessageCommand=function(self)
        local song = GAMESTATE:GetCurrentSong()
        self:settext( song and song:GetDisplayMainTitle() or "" )
    end
}

return t