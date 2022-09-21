local QBCore = exports['qb-core']:GetCoreObject()

    local PlayerData = {}
    local coolDown = false
    local GlobalTimer = 0
    local completedJob = false
    local firstComplete = false

RegisterNetEvent('cb-medloot:client:loot')
AddEventHandler('cb-medloot:client:loot', function(coords)
    local pos = GetEntityCoords(PlayerPedId())
    local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local streetLabel = street1
    if street2 ~= nil then
    streetLabel = streetLabel .. " " .. street2
    end
    local ped = PlayerPedId()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 1)
    local alertData = {
        title = "10-33 | Theft from Hospital",
        coords = coords,
    }

    if GlobalTimer == 0 then

        QBCore.Functions.Progressbar('medloot', 'Searching...', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@gangops@facility@servers@',
            anim = 'hotwire',
            flags = 16,
        }, {}, {}, 
        function()
            completedJob = true
            firstComplete = true
                TriggerServerEvent('cb-medloot:server:sendAlert', alertData, streetLabel, coords)
        end)

        function sWord()
            QBCore.Functions.Notify('You stopped searching', 'error', 5000) 
        end
        Wait(5000)
        ClearPedTasks(ped)
        FreezeEntityPosition(player, false)
        itemToGive = Config.RewardItems[math.random(1, #Config.RewardItems)]
        TriggerServerEvent('cb-medloot:server:RewardItem', itemToGive.item)
        QBCore.Functions.Notify('You Found ' .. itemToGive.label .. '!', 'success', 5000)
    else
        QBCore.Functions.Notify('You Already Looted Recently, Wait ' .. GlobalTimer .. ' Seconds Before You Try Again', 'error', 5000)
    end
end)

CreateThread(function()
    while true do
        if GlobalTimer ~= 0 and GlobalTimer > -1 and firstComplete then
            Wait(900)
            GlobalTimer = GlobalTimer - 1
        elseif completedJob then
            GlobalTimer = Config.CoolDownTimer
            completedJob = false
        end
        Wait(100)
    end
end)