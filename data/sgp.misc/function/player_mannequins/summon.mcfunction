#> sgp.misc:player_mannequins/summon
# `{current_uuid: player UUID}`
#
# Summons a smaller mannequin with the same profile, name and gear as the player 

tag @s add sgp.mannequin_init

# Summon mannequin with the player's skin and link them together
$summon mannequin ~ ~ ~ {profile: {id: $(current_uuid)}, Tags:["sgp.small_mannequin", "sgp.new"], immovable:true, hide_description:true}
execute as @e[tag=sgp.new,limit=1,type=mannequin] at @p[tag=sgp.mannequin_init] run function #bs.link:create_link_ata

# Give player's name to mannequin
summon text_display ~ ~ ~ {Tags:["sgp.temp_name"], billboard:"center", transformation:{left_rotation:[0f,0f,0f,1f], right_rotation:[0f,0f,0f,1f], translation:[0f, 0.02f, 0f], scale:[0.1f, 0.1f, 0.1f]}, text:{selector:"@p[tag=sgp.mannequin_init]"}}
ride @e[tag=sgp.temp_name,limit=1,distance=..0.1,type=text_display] mount @e[tag=sgp.new,limit=1,type=mannequin]

# Give player's gear to mannequin (will not update if player changes gear)
item replace entity @e[tag=sgp.new,limit=1,type=mannequin] armor.head from entity @s armor.head
item replace entity @e[tag=sgp.new,limit=1,type=mannequin] armor.chest from entity @s armor.chest
item replace entity @e[tag=sgp.new,limit=1,type=mannequin] armor.legs from entity @s armor.legs
item replace entity @e[tag=sgp.new,limit=1,type=mannequin] armor.feet from entity @s armor.feet
item replace entity @e[tag=sgp.new,limit=1,type=mannequin] weapon.mainhand from entity @s weapon.mainhand
item replace entity @e[tag=sgp.new,limit=1,type=mannequin] weapon.offhand from entity @s weapon.offhand

attribute @e[tag=sgp.new,limit=1,type=mannequin] scale base set 0.0625

tag @e[tag=sgp.temp_name,limit=1,type=text_display] remove sgp.temp_name
tag @e[tag=sgp.new,limit=1,type=mannequin] remove sgp.new
tag @s remove sgp.mannequin_init