fx_version "adamant"
games { "rdr3" }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'

client_script {
    "client/client.lua",
    "client/dataview.lua",
}

server_script {
    "server/server.lua",
    "server/functions.lua"
}

shared_scripts {
    'config.lua',
    'languages/translation.lua'
}

author 'Dietrich | TWH-Scripts'
description 'Updated by cl3i550n | Search props for Loot'
