local function isTargetConnected()
    for _, screen in ipairs(hs.screen.allScreens()) do
        -- Set your target screen name here
        if screen:name() == "X270 PRO" then
            return true
        end
    end
    return false
end

hs.screen.watcher.new(function()
    if isTargetConnected() then
        hs.timer.doAfter(2, function()
            -- Update screen name and connection mode as needed
            hs.execute('/Applications/BetterDisplay.app/Contents/MacOS/BetterDisplay set --name="X270 PRO" --connectionMode="bpc:8+range:full+encoding:rgb+hdrmode:sdr"')
        end)
    end
end):start()