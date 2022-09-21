local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('cb-medloot:server:RewardItem')
AddEventHandler('cb-medloot:server:RewardItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local itemToGive = Config.RewardItems[math.random(1, #Config.RewardItems)]
    TriggerClientEvent('QBCore:Notify', src, 'You Found ' .. QBCore.Shared.Items[itemToGive].label .. '!', 'success', 5000)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[itemToGive], "add")
    Player.Functions.AddItem(itemToGive, Config.RandomItemAmount)
end)
