local t = Def.ActorFrame{};

local Items = {
    ["Sections"] = { "SectionExpanded","SectionCollapsed" },
    ["Hide"] = { "SectionCount","SongName" },
};

t.OnCommand=function(self)
    SCREENMAN:GetTopScreen():GetChild("Banner"):visible(false)

    local MWheel = SCREENMAN:GetTopScreen():GetChild("MusicWheel");
    MWheel:xy( SCREEN_CENTER_X, SCREEN_CENTER_Y+109 )
    -- alright we got items
    --local DiffListRow = SCREENMAN:GetTopScreen():GetChild(""):GetChild(""):GetChild("StepsDisplayListRow")
    local WheelTable = MWheel:GetChild("MusicWheelItem")
    local NItems = THEME:GetMetric("MusicWheel","NumWheelItems")+2

    for i=1,NItems do
        WheelTable[i]:GetChild("SongNormalPart"):GetChild("Banner"):shadowlengthx(7)
        for sec in ivalues(Items.Sections) do
            WheelTable[i]:GetChild(sec):strokecolor(Color.Black):maxwidth(250)
        end
        for sec in ivalues(Items.Hide) do
            WheelTable[i]:GetChild(sec):zoom(0)
        end
    end
    SCREENMAN:GetTopScreen():GetChild("Timer"):visible(false)
    --DiffListRow:Center()
end

t.StartSelectingStepsMessageCommand=function(self)
    local MWheel = SCREENMAN:GetTopScreen():GetChild("MusicWheel");
    MWheel:stoptweening():linear(0.4):y(SCREEN_CENTER_Y+400 )
end;

local function ReloadWheelTween()
    local MWheel = SCREENMAN:GetTopScreen():GetChild("MusicWheel");
    MWheel:stoptweening():linear(0.3):y(SCREEN_CENTER_Y+450 )
    :linear(0.3):y(SCREEN_CENTER_Y+109 )
end

t.NextGroupMessageCommand=function(self) ReloadWheelTween() end;
t.PreviousGroupMessageCommand=function(self) ReloadWheelTween() end;

t.SongUnchosenMessageCommand=function(self)
    local MWheel = SCREENMAN:GetTopScreen():GetChild("MusicWheel");
    MWheel:stoptweening():linear(0.3):y( SCREEN_CENTER_Y+109 )
end;

return t;