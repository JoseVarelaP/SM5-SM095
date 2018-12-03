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

function Actor:TickSet(param)
    if param.CustomDifficulty then
        self:diffuse(CustomDifficultyToColor(param.CustomDifficulty));
    end

    return self,param
end

-- Since most screens on this theme are not within the realms of announcer data...
-- [a.k.a are not from the hardcoded announcer screens]
-- let's make a function to bring it back!
function AnnouncerManager:PlayComment(FolderLocation)
    -- Do we have an announcer enabled?
    if ANNOUNCER:GetCurrentAnnouncer() then
        local cur_anounc = ANNOUNCER:GetCurrentAnnouncer()
        -- Does the folder exist?
        if FILEMAN:GetDirListing( "Announcers/"..cur_anounc.."/"..FolderLocation ) then
            local announc = FILEMAN:GetDirListing( "Announcers/"..cur_anounc.."/"..FolderLocation.."/" )
            local auplay = 1
            -- MacOS check
            for ind,val in ipairs(announc) do
                if val == ".DS_Store" then
                    table.remove( announc, ind )
                end
            end
            -- Does the folder contain more than 1 audio file?
            if #announc > 1 then
                auplay = math.random(1,#announc)
            end
            -- Play the audio
            SOUND:PlayOnce( "Announcers/"..cur_anounc.."/".. FolderLocation .."/"..announc[auplay] )
        end
    end
end

Branch.AfterGameplay = function()
    local allFailed = STATSMAN:GetCurStageStats():AllFailed()
    -- pick an evaluation screen based on settings.
	if allFailed then
		return "ScreenSelectMusic"
	else
		return Branch.EvaluationScreen()
	end
end;
GameColor.Difficulty.Beginner = color("#fee600");
GameColor.Difficulty.Easy = color("#ff2f39");
GameColor.Difficulty.Medium = color("#ff2f39");
GameColor.Difficulty.Hard = color("#2cff00");
GameColor.Difficulty.Challenge = color("#2cff00");