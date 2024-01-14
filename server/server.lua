local VORPcore = {}

local Inventory = exports.vorp_inventory:vorp_inventoryApi()

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

local alreadySearched = {}
local alreadySearchedProp = {}
local T = Translation.Langs[Config.Lang]

local function sendNotification(source, message)
    VORPcore.NotifyRightTip(source, message, 4000)
end

local function processLoot(source, lootTable)
    local itemString = ""
    local Character = VORPcore.getUser(source).getUsedCharacter()

    for _, loot in pairs(lootTable) do
        if math.random() <= loot.chance then
            if loot.item == "money" then
                Character.addCurrency(0, loot.amount)
            elseif loot.item == "gold" then
                Character.addCurrency(1, loot.amount)
            else
                Inventory.addItem(source, loot.item, loot.amount)
            end
            itemString = itemString .. "\n_Item:_`" .. loot.label .. " x" .. loot.amount .. "`"
        end
    end

    return itemString
end

local function createDiscordMessage(source, itemString)
    local steamName = GetPlayerName(source)
    local Identifier = GetPlayerIdentifier(source)
    local discordId = Config.Discord and string.sub(GetIdentity(source, "discord"), 9) or ""
    local message = "**Steam name: **`" .. steamName .. "`**\nIdentifier:**`" .. Identifier

    if Config.Discord then
        message = message .. "` \n**Discord:** <@" .. discordId .. ">"
    end

    return message .. "\n**Items: **" .. itemString
end

local function handleLootInteraction(searched, model, source)
    if alreadySearched[searched] then
        sendNotification(source, T.alreadySearched)
        return
    end

    -- Marca o container como saqueado
    alreadySearched[searched] = true
    local lootConfig = Config.interactionLoot[model] or Config.interactionLoot["default"]
    local itemString = processLoot(source, lootConfig.loot)

    if itemString ~= "" then
        sendNotification(source, T.found .. itemString)
        if Config.Discord or Config.Logs then
            local discordMessage = createDiscordMessage(source, itemString)
            TriggerEvent("twh_searchProps:webhook", T.getReward, discordMessage)
        end
    else
        sendNotification(source, T.nothingFound)
    end

    Citizen.Wait(1000)
    alreadySearched[searched] = false
end

RegisterServerEvent("twh_searchProps:interactionLoot")
AddEventHandler("twh_searchProps:interactionLoot", function(searcher, searched, model)
    local _source = source
    handleLootInteraction(searched, model, _source)
end)

local function handlePropLootInteraction(prop, coords, source)
    if alreadySearchedProp[prop] then
        for _, v in pairs(alreadySearchedProp[prop]) do
            if CheckPos(coords.x, coords.y, coords.z, v.x, v.y, v.z, 2) then
                sendNotification(source, T.alreadySearched)
                return
            end
        end
        table.insert(alreadySearchedProp[prop], coords)
    else
        alreadySearchedProp[prop] = { coords }
    end

    local lootConfig = Config.propLoot[prop] or Config.propLoot["default"]
    local itemString = processLoot(source, lootConfig.loot)

    if itemString ~= "" then
        sendNotification(source, T.found .. itemString)
        if Config.Discord or Config.Logs then
            local discordMessage = createDiscordMessage(source, itemString)
            TriggerEvent("twh_searchProps:webhook", T.getReward, discordMessage)
        end
    else
        sendNotification(source, T.nothingFound)
    end
end

RegisterServerEvent("twh_searchProps:propLoot")
AddEventHandler("twh_searchProps:propLoot", function(prop, coords)
    local _source = source
    handlePropLootInteraction(prop, coords, _source)
end)

RegisterServerEvent('twh_searchProps:webhook')
AddEventHandler('twh_searchProps:webhook', function(title, description, text)
    Discord(Config.webhook, title, description, text, Config.webhookColor)
end)

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end
end)
