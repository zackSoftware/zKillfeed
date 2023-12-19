local blips = {}

if Config.ZonesBlips then 
    for _, Zone in ipairs(Config.ZonesLocations) do
        createZonesBlips(Zone)
    end
end

function createZonesBlips(zone)
    local blip = AddBlipForRadius(zone.x, zone.y, zone.z, zone.radius)

    SetBlipHighDetail(blip, true)
    SetBlipColour(blip, 1)  -- Set blip color as desired, 1 is blue
    SetBlipAlpha(blip, 128) -- Set blip alpha/transparency, adjust as needed

    table.insert(blips, blip) -- Store blip handle for later reference
end

function RemoveAllBlips()
    for _, blip in ipairs(blips) do
        RemoveBlip(blip)
    end
    blips = {} -- Clear the blips table
end


AddEventHandler('baseevents:onPlayerKilled', function(killerId, deathData)
    -- for k,v in pairs(deathData) do
    --     Wait(0)
    --     print(k, v)
    -- end
   -- print('Killer id: ' ..killerId)
    local weaponName = GetWeaponName(deathData)


    if IsPlayerInZone(PlayerId()) then
        print(weaponName)
        TriggerServerEvent('zKillfeed:server:playerWasKilled', killerId, GetPlayerName(PlayerId()), weaponName)
      
    end
end)

AddEventHandler('baseevents:onPlayerDied', function()
    if IsPlayerInZone(PlayerId()) then
        TriggerServerEvent('zKillfeed:server:playerDied', GetPlayerName(PlayerId()))
    end
end)

RegisterNetEvent('zKillfeed:client:feed')
AddEventHandler('zKillfeed:client:feed', function(msg)
    SendNUIMessage({
        context = msg
    })
end)


function IsPlayerInZone(playerId)
    local pPed = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(pPed)

    for _, location in ipairs(Config.ZonesLocations) do
        local locationCoords = vector3(location.x, location.y, location.z)
        local dist = #(playerCoords - locationCoords)

        if dist <= location.radius then
            return true
        end
    end

    return false
end

function GetWeaponName(data)
    hash = data.weaponhash
    --print(hash)

    ---- Add any weapon you want below this (the value of the string you return must be the same as the image name)
    if hash == GetHashKey('WEAPON_UNARMED') then return 'unarmed'
    elseif hash == GetHashKey('WEAPON_KNUCKLE') then return 'knuckle'
    elseif hash == GetHashKey('WEAPON_BOTTLE') then return 'bottle'
    elseif hash == GetHashKey('WEAPON_MACHETE') then return 'machete'
    elseif hash == GetHashKey('WEAPON_REVOLVER') then return 'revolver'
    elseif hash == GetHashKey('WEAPON_BAT') then return 'bat'
    elseif hash == GetHashKey('WEAPON_GOLFCLUB') then return 'golfclub'
    elseif hash == GetHashKey('WEAPON_CARBINERIFLE') then return 'carbine-rifle' 
    elseif hash == GetHashKey('WEAPON_ASSAULTRIFLE') then return 'assault-rifle' 
    else                                             return 'skull'
    end
end