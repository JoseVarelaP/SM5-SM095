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
        WheelTable[i]:GetChild("SongNormalPart"):GetChild("Banner"):shadowlength(10)
        for sec in ivalues(Items.Sections) do
            WheelTable[i]:GetChild(sec):strokecolor(Color.Black):maxwidth(250)
        end
        for sec in ivalues(Items.Hide) do
            WheelTable[i]:GetChild(sec):zoom(0)
        end
    end
    --DiffListRow:Center()
end

return t;