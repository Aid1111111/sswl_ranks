ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Add XP to player
RegisterNetEvent('sswl:addXP')
AddEventHandler('sswl:addXP', function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    MySQL.Async.fetchScalar('SELECT sswl_xp FROM users WHERE identifier = @id', {
        ['@id'] = xPlayer.identifier
    }, function(currentXP)
        currentXP = currentXP or 0
        local newXP = currentXP + amount

        -- Save XP
        MySQL.Async.execute('UPDATE users SET sswl_xp = @xp WHERE identifier = @id', {
            ['@xp'] = newXP,
            ['@id'] = xPlayer.identifier
        })

        -- Send XP to client
        TriggerClientEvent('sswl:updateXP', source, newXP)
    end)
end)

-- XP triggers
RegisterNetEvent('sswl:addKillXP')
AddEventHandler('sswl:addKillXP', function() TriggerEvent('sswl:addXP', 10) end)

RegisterNetEvent('sswl:addSaleXP')
AddEventHandler('sswl:addSaleXP', function() TriggerEvent('sswl:addXP', 25) end)

RegisterNetEvent('sswl:addObjectiveXP')
AddEventHandler('sswl:addObjectiveXP', function() TriggerEvent('sswl:addXP', 50) end)
