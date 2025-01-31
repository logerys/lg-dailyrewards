fx_version 'cerulean'
game 'gta5'

author 'Logerys'
description 'Advanced system for daily rewards'
version '1.0.0'

shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

server_script {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

client_script {
    'client.lua'
}

dependencies {
    'es_extended',
    'ox_lib'
}

lua54 'yes'
