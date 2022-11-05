-- Resource Metadata

fx_version 'cerulean'
game 'gta5'

lua54 'yes'

description 'Cooking Simulator'
author 'Jvson/JasonTheMan - DotSoft'
version '1.0.0'

shared_script 'config.lua'

server_scripts {
	'server/main.lua'
}

client_scripts {
	'client/main.lua'
}

dependencies {
	'es_extended'
}