local updateInterval = 2.0
local timeSinceLastUpdate = 2.0
local currZone = "no zone yet"


local realms = { }
realms[4456] = "en - Nethergarde Keep"

-- Updates the dungeon note if enough time has elapsed
-- and if we are in a new zone.

function onupdate(self, elapsed)
    timeSinceLastUpdate = timeSinceLastUpdate + elapsed;
    if timeSinceLastUpdate > updateInterval then
        updateNotes()
        timeSinceLastUpdate = 0
    end
end

-- Updates the dungeon note if we are in a new zone.

function updateNotes()
    local newZone = GetZoneText()
    if newZone ~= currZone then
        currZone = newZone
        local note = findRealms()
        TestAddon3_MainFrame_xCoorNum:SetText(note)
    end
end

-- Returns the realms.

function findRealms()
    return findRealm("player") .. findRealm("party2") .. findRealm("party3") .. findRealm("party4")
end

function findRealm(unit)
    local guid = UnitGUID(unit)  -- e.g. "Player-4456-..."
    if not guid then return "" end
    local _, realmNumStr = strsplit("-", guid)
    local realmNum = tonumber(realmNumStr)
    local realmInfo = realms[realmNum]
    if realmInfo then
        return realmInfo .. "\n"
    else
        return realmNumStr .. "\n"
    end
end



-- local _, _, _, _, _, _, realm = GetPlayerInfoByGUID(guid)
-- local name, rules, locale, region, timezone = strsplit(",", info)

--    [4456]="Nethergarde Keep,PvE,enUS,EU",
