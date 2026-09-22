
#> sgp.kits:abilities/tnt/explode_at

# Several Pyromanes can schedule this global callback for the same tick. Mark a
# charge as soon as its lingering fire is dispatched so later callbacks cannot
# process the same fuse-1 TNT again.
# warn-off target-selector-no-dimension (We want them all wherever they are UwU)
execute as @e[tag=sgp.tnt,tag=!sgp.tnt_fire_spawned,nbt={fuse:1s},type=tnt] at @s run function sgp.kits:abilities/tnt/summon_fire
