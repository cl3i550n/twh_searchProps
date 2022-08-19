Config = {}

Config.defaultlang = "de"

Config.props={"p_dresser05x","p_armoireregal01"}

Config.keys ={
    searchKey = 0x760A9C6F --G
}

Config.propLoot ={
    ["default"] = {     --when prop not specified use this loot
        label = "Objekt",
        distance = 1.0,
        animation = 'WORLD_HUMAN_CROUCH_INSPECT',
        loot = {
            {item= "money",amount=1, chance = 1.0},  --you can set money, gold or any item you want. Chance is set in percentage: 0.1 = 10%
        }
        
    },
    ["p_dresser05x"] = {    --specified props has to be in Config.props aswell
        label = "Schrank",
        distance = 1.0,
        animation = 'WORLD_HUMAN_CROUCH_INSPECT',
        loot = {
            {item= "gold",amount=1, chance = 1.0},
        }

    }
}

-------------------------------------------
------------Object Interactions------------

Config.enableInteraction= true --enable loot when interact with drawers,chests or other interactable objects in the world

Config.alreadySearchedMessage = true    --display message when players should be informed when it was been searched already

Config.interactionLoot ={  --Add more Objects with Hash Values: https://raw.githubusercontent.com/femga/rdr3_discoveries/master/objects/object_list.lua
    ["default"] = {        --when model not specified use this loot
        loot = {
            {item= "money",amount=1, chance = 0.2},
        }
        
    },
    [-1798680490] = {
        loot = {
            {item= "gold",amount=1, chance = 0.1},
            {item= "feather",amount=2, chance = 0.1},
        }

    },
    [-509256108] = {
        loot = {
            {item= "gold",amount=2, chance = 0.5},
            {item= "jawbone",amount=1, chance = 0.1},
        }

    }
}
