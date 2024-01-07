local VORPcore = {}
local VorpInv = {}

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

TriggerEvent("getCore", function(core)
    VORPcore = core
end)


local alreadySearched = {}
local alreadySearchedProp = {}
local message
local discordIdentity
local discordId

local T = Translation.Langs[Config.Lang]

RegisterServerEvent("twh_searchProps:interactionLoot")
AddEventHandler("twh_searchProps:interactionLoot", function(searcher, searched, model)
    local _source = source
    local User = VORPcore.getUser(_source)
    local Character = User.getUsedCharacter
    local entityModel = model

    local Identifier = GetPlayerIdentifier(_source)
    local steamName = GetPlayerName(_source)
    if Config.Discord then
        discordIdentity = GetIdentity(_source, "discord")
        discordId = string.sub(discordIdentity, 9)
    end
    local itemstring = ""
    local itemsFound = {}

    if not alreadySearched[searched] then
        alreadySearched[searched] = searcher
        local found = false
        if Config.interactionLoot[entityModel] then
            for k, v in pairs(Config.interactionLoot[entityModel].loot) do
                local chance = math.random()
                if chance <= v.chance then
                    found = true
                    switch(v.item):caseof {
                        ["money"] = function()
                            Character.addCurrency(0, v.amount)
                            table.insert(itemsFound, { name = v.label, amount = v.amount })
                        end,
                        ["gold"]  = function()
                            Character.addCurrency(1, v.amount)
                            table.insert(itemsFound, { name = v.label, amount = v.amount })
                        end,
                        default   = function()
                            VorpInv.addItem(_source, v.item, v.amount)
                            table.insert(itemsFound, { name = v.label, amount = v.amount })
                        end
                    }
                    itemstring = itemstring .. "\n_Item:_`" .. tostring(v.label) .. " x" .. tostring(v.amount) .. "`"
                end
            end
        else
            for k, v in pairs(Config.interactionLoot["default"].loot) do
                local chance = math.random()
                if chance <= v.chance then
                    found = true
                    switch(v.item):caseof {
                        ["money"] = function()
                            Character.addCurrency(0, v.amount)
                            table.insert(itemsFound, { name = v.label, amount = v.amount })
                        end,
                        ["gold"]  = function()
                            Character.addCurrency(1, v.amount)
                            table.insert(itemsFound, { name = v.label, amount = v.amount })
                        end,
                        default   = function()
                            VorpInv.addItem(_source, v.item, v.amount)
                            table.insert(itemsFound, { name = v.label, amount = v.amount })
                        end
                    }
                    itemstring = itemstring .. "\n_Item:_`" .. tostring(v.label) .. " x" .. tostring(v.amount) .. "`"
                end
            end
        end

        Citizen.Wait(1000)

        if found then

            for _, item in ipairs(itemsFound) do
                itemStringFound = T.found .. " " .. tostring(item.name) .. " " .. T.quantity .. " " .. tostring(item.amount)
            end

            VORPcore.NotifyRightTip(_source, itemStringFound, 4000)

            if Config.Discord then
                message = "**Steam name: **`" ..
                    steamName .. "`**\nIdentifier:**`" ..
                    Identifier .. "` \n**Discord:** <@" ..
                    discordId .. ">" .. "\n**Items: **" ..
                    itemstring
            else
                message = "**Steam name: **`" ..
                    steamName .. "`**\nIdentifier:**`" ..
                    Identifier .. "\n**Items: **" ..
                    itemstring
            end
            if Config.Logs then
                TriggerEvent("twh_searchProps:webhook", T.getReward, message)
            end
        else
            VORPcore.NotifyRightTip(_source, T.nothingFound, 4000)
        end
    else
        if Config.alreadySearchedMessage then
            Citizen.Wait(1000)
            VORPcore.NotifyRightTip(_source, T.alreadySearched, 4000)
        end
    end
end)

RegisterServerEvent("twh_searchProps:propLoot")
AddEventHandler("twh_searchProps:propLoot", function(prop, coords)
    local _source = source
    local User = VORPcore.getUser(_source)
    local Character = User.getUsedCharacter

    local Identifier = GetPlayerIdentifier(_source)
    local steamName = GetPlayerName(_source)
    if Config.Discord then
        discordIdentity = GetIdentity(_source, "discord")
        discordId = string.sub(discordIdentity, 9)
    end
    local itemstring = ""
    local itemsFound = {}

    local propFound = false
    if alreadySearchedProp[prop] then
        for k, v in pairs(alreadySearchedProp[prop]) do
            print(v)
            print(v.x)
            if CheckPos(coords.x, coords.y, coords.z, v.x, v.y, v.z, 2) then
                propFound = true
            end
        end
        alreadySearchedProp[prop][#alreadySearchedProp[prop] + 1] = coords
    else
        alreadySearchedProp[prop] = { coords }
    end

    if not propFound then
        local found = false
        if Config.propLoot[prop] then
            for k, v in pairs(Config.propLoot[prop].loot) do
                local chance = math.random()
                if chance <= v.chance then
                    found = true
                    switch(v.item):caseof {
                        ["money"] = function()
                            Character.addCurrency(0, v.amount)
                            table.insert(itemsFound, { name = v.label, amount = v.amount })
                        end,
                        ["gold"]  = function()
                            Character.addCurrency(1, v.amount)
                            table.insert(itemsFound, { name = v.label, amount = v.amount })
                        end,
                        default   = function()
                            VorpInv.addItem(_source, v.item, v.amount)
                            table.insert(itemsFound, { name = v.label, amount = v.amount })
                        end
                    }
                    itemstring = itemstring .. "\n_Item:_`" .. tostring(v.label) .. " x" .. tostring(v.amount) .. "`"
                end
            end
        else
            for k, v in pairs(Config.propLoot["default"].loot) do
                local chance = math.random()
                if chance <= v.chance then
                    found = true
                    switch(v.item):caseof {
                        ["money"] = function()
                            Character.addCurrency(0, v.amount)
                        end,
                        ["gold"]  = function()
                            Character.addCurrency(1, v.amount)
                        end,
                        default   = function()
                            VorpInv.addItem(_source, v.item, v.amount)
                        end
                    }
                    itemstring = itemstring .. "\n_Item:_`" .. tostring(v.label) .. " x" .. tostring(v.amount) .. "`"
                end
            end
        end

        Citizen.Wait(1000)

        if found then
            for _, item in ipairs(itemsFound) do
                itemStringFound = T.found .. " " .. tostring(item.name) .. " " .. T.quantity .. " " .. tostring(item.amount)
            end

            VORPcore.NotifyRightTip(_source, itemStringFound, 4000)

            if Config.Discord then
                message = "**Steam name: **`" ..
                    steamName .. "`**\nIdentifier:**`" ..
                    Identifier .. "` \n**Discord:** <@" ..
                    discordId .. ">" .. "\n**Items: **" ..
                    itemstring
            else
                message = "**Steam name: **`" ..
                    steamName .. "`**\nIdentifier:**`" ..
                    Identifier .. "\n**Items: **" ..
                    itemstring
            end
            if Config.Logs then
                TriggerEvent("twh_searchProps:webhook", T.getReward, message)
            end
        else
            VORPcore.NotifyRightTip(_source, T.nothingFound, 4000)
        end
    else
        if Config.alreadySearchedMessage then
            Citizen.Wait(1000)
            VORPcore.NotifyRightTip(_source, T.alreadySearched, 4000)
        end
    end
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
