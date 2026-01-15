fx_version 'cerulean'
game 'gta5'

author 'SouthsideWL'
description 'Southside WL Ranked System ESX'
version '1.0.0'

client_scripts {
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/ui.css',
    'html/rankup.html',
    'html/rankup.css'
}
