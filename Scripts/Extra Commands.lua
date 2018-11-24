function ThemeManager:GetPathV(file1,file2)
    return "/"..THEME:GetCurrentThemeDirectory().."Video/"..file1 .. file2
end

Branch.TitleMenu = function() return "SM_TitleMenu" end

function ScreenManager:NScreen(screenname)
    SCREENMAN:PlayStartSound()
    return SCREENMAN:GetTopScreen():SetNextScreenName( screenname ):StartTransitioningScreen("SM_GoToNextScreen")
end

function Sprite:Pix()
    self:SetTextureFiltering(false)
    return self
end

function GameState:GetScore(pn)
	return STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetScore()
end;

function GameState:Side(pn)
    if pn == PLAYER_1 then return -1 end
    return 1
end

function Actor:GetWheelTrans(offsetFromCenter,itemIndex,numItems)
    self:x(offsetFromCenter*92):y(0)
    if itemIndex == 5 then
        self:xy((offsetFromCenter*92)+60,-60)
    end
	self:rotationz(-45):zoom(.7)
    
    return self,offsetFromCenter,itemIndex,numItems
end