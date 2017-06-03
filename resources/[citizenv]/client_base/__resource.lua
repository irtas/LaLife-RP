-- Client Base Scripts


client_script 'pointing.lua'
client_script 'neverwanted.lua'
client_script 'overhead.lua'
client_script 'handsup.lua'
client_script 'vocalchat.lua'
client_script 'stamina.lua'
client_script 'sirencontrols.net.dll'

client_script 'lock/client/main.lua'
client_script 'lock/lock.lua'

client_script 'carhud.lua'

server_script 'lock/server/main.lua'
server_script 'lock/lock_s.lua'

ui_page('lock/client/html/index.html')


files({
    'lock/client/html/index.html',
    'lock/client/html/sounds/lock.ogg',
    'lock/client/html/sounds/unlock.ogg',
    'lock/client/html/sounds/demo.ogg'
})
