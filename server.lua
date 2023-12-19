RegisterNetEvent('zKillfeed:server:playerWasKilled')
AddEventHandler('zKillfeed:server:playerWasKilled', function(killerId, whoWasKilled, weaponName)
    --print(tostring(weaponName))
    TriggerClientEvent('Killfeed:client:feed', -1, '<strong>' .. tostring(GetPlayerName(killerId)) .. '</strong> <img src="img/'.. tostring(weaponName) ..'.webp" width="30px" style="transform: rotate(-30deg);;"> <strong>' .. tostring(whoWasKilled) .. '</strong>')
end)

RegisterNetEvent('zKillfeed:server:playerDied')
AddEventHandler('zKillfeed:server:playerDied', function(whoDied)
    TriggerClientEvent('Killfeed:client:feed', -1, '<img src="img/skull.webp" width="15px" style="margin-top: 2px;"> <strong>' .. tostring(whoDied) .. '</strong>')
end)