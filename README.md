# 🎁 **FiveM Daily Rewards System**

## 📖 **Description**
This advanced daily rewards system for FiveM is designed using the **ESX** framework and **Ox Lib** library. It allows players to claim rewards for logging into the server daily. The system includes:
- 🗂️ Interactive menu to display rewards.
- 💰 Customizable rewards (money, items, weapons, or custom functions).
- 🛠️ Automatic data storage in a database.
- 🔗 Logging claimed rewards to Discord via webhook.
- ⏱️ Reset interval for daily rewards.
- ✨ Special rewards with custom functions.

---

## 🚀 **Features**
- **Daily Rewards:** Players can claim unique rewards every day.
- **Interactive Menu:** Ox Lib menu displays all available rewards and their status.
- **Database Storage:** Player data is securely stored in a MySQL database.
- **Discord Webhook Integration:** Logs claimed rewards to a Discord server.
- **Reset Interval:** Rewards reset after a configurable time interval (e.g., 24 hours).
- **Special Rewards:** Define custom functions for special days.

---

## 📋 **Requirements**
1. [FiveM Server](https://fivem.net/) 🖥️
2. [ESX Framework](https://github.com/esx-framework/esx_core) ⚙️
3. [Ox Lib](https://overextended.github.io/docs/ox_lib/) 📚
4. [MySQL Async](https://github.com/brouznouf/fivem-mysql-async) (or any other database library) 🗄️
5. MySQL Database 💾

---

## ⚙️ **Installation**
1. Download this repository and place it in your `resources` folder on your server.
2. Add the following lines to your `server.cfg`:
ensure ox_lib
ensure es_extended
ensure daily_rewards

3. Create the database table using the following SQL script:
CREATE TABLE IF NOT EXISTS daily_rewards (
id INT NOT NULL AUTO_INCREMENT,
identifier VARCHAR(50) NOT NULL,
last_claimed_time BIGINT NOT NULL,
current_day INT NOT NULL DEFAULT 1,
PRIMARY KEY (id),
UNIQUE KEY identifier (identifier)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

4. Open the `config.lua` file and configure:
- The reset interval for rewards (`Config.ResetInterval`).
- Rewards for each day (`Config.DailyRewards`).
- Discord webhook URL (`Config.DiscordWebhookURL`) for logging claims to Discord.

---

## 🔧 **Configuration**
You can customize the following settings in the `config.lua` file:

### 🎁 Daily Rewards
Each day can have a different type of reward:
Config.DailyRewards = {
{day = 1, rewardType = 'money', amount = 500, label = '500$'},
{day = 2, rewardType = 'item', itemName = 'bread', amount = 5, label = '5x Bread'},
{day = 3, rewardType = 'weapon', weaponName = 'WEAPON_PISTOL', amount = 1, label = 'Pistol'},
{day = 4, rewardType = 'money', amount = 1000, label = '1000$'},
{day = 5, rewardType = 'item', itemName = 'water', amount = 10, label = '10x Water'},
{day = 6, rewardType = 'money', amount = 1500, label = '1500$'},
{day = 7, rewardType = 'special', customFunction = 'customRewardFunction', label = 'Special Reward'}
}


### ✨ Special Functions
Define custom functions for special days:
Config.SpecialRewardsFunctions = {
customRewardFunction = function(player)
player.addMoney(2000)
player.addInventoryItem('goldbar', 1)
end
}


### ⏱️ Reset Interval
Specifies the time interval between claiming the next reward (in seconds):
Config.ResetInterval = 86400 -- 24 hours


### 🔗 Discord Webhook
To log claimed rewards to Discord, set up your webhook URL:
Config.DiscordWebhookURL = "https://your-webhook-url-here"


---

## 🕹️ **Usage**
Players can open the daily rewards menu using the command:
/dailyrewards

The menu displays all days and their respective rewards. If the current day's reward is available, players can click on it to claim it.

---

## 📂 **Project Structure**
daily_rewards/
├── client.lua # Client-side script (interactive menu and server communication)
├── server.lua # Server-side script (reward logic and database handling)
├── config.lua # Configuration file (rewards, intervals, webhook)
├── fxmanifest.lua # Manifest file for FiveM
└── README.md # Project documentation


---

## 🔗 **Discord Logging**
Every claimed reward is logged to Discord via webhook. Example message:

> 🎉 Player **JohnDoe** claimed the reward: **500$**

---

## 📈 **Changelog**
### Version 1.0.0
- Initial release of the Daily Rewards System.
- Support for ESX framework and Ox Lib.
- Interactive menu for players.
- Data storage in MySQL database.
- Logging claims to Discord via webhook.

---

## 📜 **License**
This project is licensed under the Apacha License. For more details, see the LICENSE file.
