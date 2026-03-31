# sgp.mineurs:bounty/end
#
# make the event end 

execute as @a[tag=sgp.wanted] run function sgp.mineurs:bounty/reward/message
tellraw @a [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"translate":"sgp.mineurs:bounty_survivors", "fallback":"Les survivants du bounty parmi les recherchés sont %s", "with":[{"selector":"@a[tag=sgp.wanted]", "color":"white"}], "color":"yellow"}]
tag @a[tag=sgp.wanted] remove sgp.wanted
effect clear @a[tag=sgp.wanted] minecraft:glowing