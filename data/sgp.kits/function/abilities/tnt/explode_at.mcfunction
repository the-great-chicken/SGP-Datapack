#> sgp.kits:abilities/tnt/explode_at

# warn-off target-selector-no-dimension (We want them all wherever they are UwU)
execute as @e[tag=sgp.tnt,nbt={fuse:1s},type=tnt] at @s run function sgp.kits:abilities/tnt/summon_fire
