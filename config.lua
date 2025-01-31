Config = {}

Config.DailyRewards = {
    {day = 1, rewardType = 'money', amount = 500, label = '500$'},
    {day = 2, rewardType = 'item', itemName = 'bread', amount = 5, label = '5x Chleba'},
    {day = 3, rewardType = 'weapon', weaponName = 'WEAPON_PISTOL', amount = 1, label = 'Pistol'},
    {day = 4, rewardType = 'money', amount = 1000, label = '1000$'},
    {day = 5, rewardType = 'item', itemName = 'water', amount = 10, label = '10x Voda'},
    {day = 6, rewardType = 'money', amount = 2000, label = '2000$'},
    {day = 7, rewardType = 'special', specialRewardFunction = function(playerId)
        local xPlayer = ESX.GetPlayerFromId(playerId)
        xPlayer.addMoney(5000)
        xPlayer.addInventoryItem('gold_bar', 1)
    end, label = '5000$ + Zlatý prut'}
}

Config.ResetInterval = 86400

Config.Debug = true

Config.DiscordWebhookURL = "https://your-webhook-url-here"
