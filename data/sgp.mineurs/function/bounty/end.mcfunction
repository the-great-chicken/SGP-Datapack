# sgp.mineurs:bounty/end
#
# make the event end 

execute as @a[tag=sgp.wanted] run function sgp.mineurs:bounty/reward/message
tellraw @a [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text":"Les survivants du bounty parmi les recherchés sont ","color": "yellow"},{"color":"white","selector":"@a[tag=sgp.wanted]"}]
tag @a[tag=sgp.wanted] remove sgp.wanted
effect clear @a[tag=sgp.wanted] minecraft:glowing