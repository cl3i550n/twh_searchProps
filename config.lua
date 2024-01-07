Config = {}

-- Language setting - English | Portuguese_PT | Portuguese_BR | French | German | Spanish
Config.Lang = "English" -- Set the script language (Brazilian Portuguese in this case)

-- Webhook settings
Config.Logs = false                                     -- Set whether logs are enabled or disabled
Config.Discord = false                                  -- Set whether the Discord whitelist is enabled
Config.webhook = ""                                     -- Set the webhook URL for logs
Config.webhookColor = 16711680                          -- Set the webhook color (default is red)
Config.name = "twh_searchProps"                       -- Set the script name for logs
Config.logo = "https://via.placeholder.com/30x30"       -- Header logo URL
Config.footerLogo = "https://via.placeholder.com/30x30" -- Footer logo URL
Config.Avatar = "https://via.placeholder.com/30x30"     -- Avatar URL

-- List of properties (objects) that can be looted
Config.props = { "p_dresser05x", "p_armoireregal01" }

-- Activation keys
Config.keys = {
    searchKey = 0x760A9C6F -- G key to activate interaction
}

-- Loot settings for each property
Config.propLoot = {
    ["default"] = {                               -- When the property is not specified, use this default loot
        label = "Object",                         -- Label for the property
        distance = 1.0,                           -- Distance from which the player can interact
        lootTime = 10000,                         -- Time required to perform the loot (in milliseconds)
        animation = 'WORLD_HUMAN_CROUCH_INSPECT', -- Animation to be played when looting
        loot = {                                  -- Itens e suas quantidades com chances de saque
            { item = "money",               label = "Dolares",    amount = 1, chance = 0.2 },
            { item = "apple",               label = "Maçã",       amount = 1, chance = 0.7 },
            { item = "water",               label = "Água",       amount = 1, chance = 0.7 },
            { item = "consumable_pear",     label = "Pera",       amount = 1, chance = 0.6 },
            { item = "salt",                label = "Sal",        amount = 1, chance = 0.2 },
            { item = "eggs",                label = "Ovos",       amount = 1, chance = 0.2 },
            { item = "milk",                label = "Leite",      amount = 1, chance = 0.2 },
            { item = "consumable_medicine", label = "Remédio",    amount = 1, chance = 0.1 },
            { item = "antipoison",          label = "Antídoto 1", amount = 1, chance = 0.1 },
            { item = "antipoison2",         label = "Antídoto 2", amount = 1, chance = 0.1 },
            -- Adicione mais itens aqui, se necessário
        }
    },
    ["p_dresser05x"] = { -- Specific properties must be in the props list (Config.props)
        label = "Wardrobe",
        distance = 1.0,
        lootTime = 10000,
        animation = 'WORLD_HUMAN_CROUCH_INSPECT',
        loot = {
            { item = "gold", label = "Ouro", amount = 1, chance = 1.0 },
            -- Add more items here if needed
        }
    }
}

-------------------------------------------
------------Object Interactions------------

Config.enableInteraction = true      -- Enable or disable interaction with drawers, chests, or other interactive objects in the world

Config.alreadySearchedMessage = true -- Display a message when players should be informed that the object has already been looted

Config.interactionLoot = {           -- Loot settings for interactions with objects in the world
    ["default"] = {                  -- When the object model is not specified, use this default loot
        loot = {                     -- Itens e suas quantidades com chances de saque
            { item = "money",               label = "Dolares",    amount = 1, chance = 0.2 },
            { item = "apple",               label = "Maçã",       amount = 1, chance = 0.7 },
            { item = "water",               label = "Água",       amount = 1, chance = 0.7 },
            { item = "consumable_pear",     label = "Pera",       amount = 1, chance = 0.6 },
            { item = "salt",                label = "Sal",        amount = 1, chance = 0.2 },
            { item = "eggs",                label = "Ovos",       amount = 1, chance = 0.2 },
            { item = "milk",                label = "Leite",      amount = 1, chance = 0.2 },
            { item = "consumable_medicine", label = "Remédio",    amount = 1, chance = 0.1 },
            { item = "antipoison",          label = "Antídoto 1", amount = 1, chance = 0.1 },
            { item = "antipoison2",         label = "Antídoto 2", amount = 1, chance = 0.1 },
            -- Adicione mais itens aqui, se necessário
        }
    },
    [-1798680490] = { -- Example of a specific object model (you can add more)
        loot = {
            { item = "gold",     label = "Ouro", amount = 1, chance = 0.1 },
            { item = "feather",  label = "Pena", amount = 2, chance = 0.1 },
            -- Add more items here if needed
        }
    },
    [-509256108] = { -- Another example of a specific object model
        loot = {
            { item = "gold",     label = "Ouro", amount = 2, chance = 0.5 },
            { item = "apple",  label = "Maçã", amount = 1, chance = 0.1 },
            -- Add more items here if needed
        }
    }
}
