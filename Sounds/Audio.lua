local tune = "_silent"

if not getenv("MenuSong") then
    setenv("MenuSong",SONGMAN:GetRandomSong())
end

if getenv("MenuSong") then
    tune = getenv("MenuSong"):GetMusicPath()
end

return tune