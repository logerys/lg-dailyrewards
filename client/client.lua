local playerRewardData = nil

CreateThread(function()
    ESX.TriggerServerCallback('daily_rewards:getPlayerData', function(data)
        playerRewardData = data
    end)
end)

local function openDailyRewardsMenu()
    if not playerRewardData then
        lib.notify({
            type = 'error',
            description = 'Data hráče nebyla načtena. Zkuste to znovu.'
        })
        return
    end

    local menuOptions = {}

    for i, reward in ipairs(Config.DailyRewards) do
        local isCurrentDay = (playerRewardData.currentDay == i)
        local isClaimable = isCurrentDay and (os.time() - playerRewardData.lastClaimedTime >= Config.ResetInterval)

        table.insert(menuOptions, {
            title = string.format("Den %d: %s", i, reward.label),
            description = isClaimable and "Klikni pro vyzvednutí!" or (isCurrentDay and "Odměna je dostupná později." or "Tuto odměnu již nelze získat."),
            disabled = not isClaimable,
            onSelect = function()
                TriggerServerEvent('daily_rewards:claimReward')
            end
        })
    end

    lib.registerContext({
        id = 'daily_rewards_menu',
        title = 'Denní Odměny',
        options = menuOptions
    })

    lib.showContext('daily_rewards_menu')
end

RegisterCommand('dailyrewards', function()
    openDailyRewardsMenu()
end)

RegisterNetEvent('daily_rewards:updatePlayerData', function(data)
    playerRewardData = data

    lib.notify({
        type = 'success',
        description = 'Odměna byla úspěšně vyzvednuta!'
    })

    openDailyRewardsMenu()
end)

RegisterNetEvent('daily_rewards:error', function(message)
    lib.notify({
        type = 'error',
        description = message
    })
end)
