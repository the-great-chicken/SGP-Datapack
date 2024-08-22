execute as @a[tag=sgp.wanted] run function sgp.mineurs:bounty/reward/message
tellraw @a [{"storage":"sgp.text", "nbt":"prefix", "interpret":true},{"text":"Les survivants recherchés sont ","color": "yellow"},{"color":"white","selector":"@a[tag=sgp.wanted]"}]
tag @a[tag=sgp.wanted] remove sgp.wanted