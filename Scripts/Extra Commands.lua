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

function Actor:GetWheelTrans(offsetFromCenter)
    self:x(offsetFromCenter*92);
	self:rotationz(-45);
	self:shadowlength(16);
    self:zoom(.7);
    
    return self,offsetFromCenter,itemIndex,numItems
end