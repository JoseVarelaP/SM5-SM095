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
    self:x(offsetFromCenter*92+(itemIndex == 5 and math.cos( offsetFromCenter )*60 or 0))
    :y( itemIndex == 5 and math.cos( offsetFromCenter )*-60 or 0 )
	self:rotationz(-45):zoom(.7)
    
    return self,offsetFromCenter,itemIndex,numItems
end

function Actor:TickSet(param)
    if param.CustomDifficulty then
        self:diffuse(CustomDifficultyToColor(param.CustomDifficulty));
    end

    return self,param
end

-- pick an evaluation screen based on settings.
Branch.AfterGameplay = function()
	return STATSMAN:GetCurStageStats():AllFailed() and "ScreenSelectMusic" or Branch.EvaluationScreen()
end;
GameColor.Difficulty.Beginner = color("#fee600");
GameColor.Difficulty.Easy = color("#ff2f39");
GameColor.Difficulty.Medium = color("#ff2f39");
GameColor.Difficulty.Hard = color("#2cff00");
GameColor.Difficulty.Challenge = color("#2cff00");