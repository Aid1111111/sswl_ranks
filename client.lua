ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local uiOpen = false
local playerXP = 0
local playerRank = "Rookie"
local currentBadge = "🟤"

local ranks = {
    {name = "Rookie", xp = 0, badge = "🟤"},
    {name = "Apprentice", xp = 100, badge = "⚪"},
    {name = "Warrior", xp = 250, badge = "🟡"},
    {name = "Elite", xp = 500, badge = "🔵"},
    {name = "Champion", xp = 1000, badge = "👑"},
}

-- Update rank and trigger banner
function updateRank()
    local oldRank = playerRank
    for i = #ranks, 1, -1 do
        if playerXP >= ranks[i].xp then
            playerRank = ranks[i].name
            currentBadge = ranks[i].badge
            break
        end
    end

    if oldRank ~= playerRank then
        SendNUIMessage({
            action = "rankUp",
            rank = playerRank,
            badge = currentBadge
        })
    end
end

-- Receive XP from server
RegisterNetEvent('sswl:updateXP')
AddEventHandler('sswl:updateXP', function(xp)
    playerXP = xp
    updateRank()
    SendNUIMessage({
        action = "updateUI",
        xp = playerXP,
        rank = playerRank,
        badge = currentBadge
    })
end)

-- Toggle UI with key 9
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 56) then -- 9 key
            uiOpen = not uiOpen
            SetNuiFocus(uiOpen, uiOpen)
            SendNUIMessage({action = uiOpen and "show" or "hide"})
        end
    end
end)
