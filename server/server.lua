ESX = exports["es_extended"]:getSharedObject()

local playerRewardsData = {}

local function initializePlayerData(identifier)
    if not playerRewardsData[identifier] then
        playerRewardsData[identifier] = {
            lastClaimedTime = os.time(),
            currentDayIndex = 1,
            rewardHistory = {}
        }
    end
end

local function logRewardToDiscord(playerName, rewardLabel)
    if Config.DiscordWebhookURL ~= "" then
        PerformHttpRequest(Config.DiscordWebhookURL, function(err, text, headers) 
            if Config.Debug then
                print("[DEBUG] Webhook response: " .. tostring(err))
            end
        end, 'POST', json.encode({
            username = "Daily Rewards",
            embeds = {{
                title = "Denní Odměna",
                description = string.format("Hráč **%s** vyzvedl odměnu: **%s**", playerName, rewardLabel),
                color = 3066993,
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }), { ['Content-Type'] = 'application/json' })
    end
end

local function handleRewardClaim(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    initializePlayerData(identifier)

    local playerData = playerRewardsData[identifier]
    local currentTimeStamp = os.time()

    if currentTimeStamp - playerData.lastClaimedTime < Config.ResetInterval then
        TriggerClientEvent('ox_lib:notify', source, {type='error', description="Musíš počkat na další den!"})
        return
    end

    local rewardDataIndex = playerData.currentDayIndex
    local rewardDataTableEntry = Config.DailyRewards[rewardDataIndex]
    
    if not rewardDataTableEntry then return end

    if rewardDataTableEntry.rewardType == 'money' then
        xPlayer.addMoney(rewardDataTableEntry.amount)
    elseif rewardDataTableEntry.rewardType == 'item' then
        xPlayer.addInventoryItem(rewardDataTableEntry.itemName, rewardDataTableEntry.amount)
    elseif rewardDataTableEntry.rewardType == 'weapon' then
        xPlayer.addWeapon(rewardDataTableEntry.weaponName, rewardDataTableEntry.amount)
    elseif rewardDataTableEntry.rewardType == 'special' and Config.SpecialRewardsFunctions[rewardDataTableEntry.customFunction] then
        Config.SpecialRewardsFunctions[rewardDataTableEntry.customFunction](xPlayer)
    end

    playerData.lastClaimedTime = currentTimeStamp
    playerData.currentDayIndex = playerData.currentDayIndex + 1

    if playerData.currentDayIndex > #Config.DailyRewards then
        playerData.currentDayIndex = 1
    end

    table.insert(playerData.rewardHistory, {
        rewardLabel = rewardDataTableEntry.label,
        timeClaimed = currentTimeStamp
    })

    TriggerClientEvent('ox_lib:notify', source, {type='success', description="Odměna byla úspěšně vyzvednuta: " .. rewardDataTableEntry.label})
    
    logRewardToDiscord(xPlayer.getName(), rewardDataTableEntry.label)
end

RegisterServerEvent('daily_rewards:claimReward')
AddEventHandler('daily_rewards:claimReward', function()
    handleRewardClaim(source)
end)

ESX.RegisterServerCallback('daily_rewards:getPlayerData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    initializePlayerData(xPlayer.identifier)
    cb(playerRewardsData[xPlayer.identifier])
end)
