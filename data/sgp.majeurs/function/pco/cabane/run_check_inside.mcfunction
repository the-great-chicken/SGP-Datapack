#> sgp.majeurs:pco/cabane/run_check_inside
# 
# Run the function to check if players are inside their cabane,
# and show them their remaining time in seconds.

execute as @a[tag=sgp.in_game] \
    run scoreboard players operation @s sgp.temps_cabane_pco_secondes = @s sgp.temps_cabane_pco

execute as @a[tag=sgp.in_game] \
    run scoreboard players operation @s sgp.temps_cabane_pco_secondes /= 100 sgp.dummy

execute as @a[tag=sgp.in_game] \
    run function sgp.majeurs:pco/cabane/inside_actionbar


execute as @a[team=sgp.Poule] at @s \
    run function sgp.majeurs:pco/cabane/check_if_inside with entity @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_cage_storage",nbt={data:{cage:"poule"}},limit=1] data.fill

execute as @a[team=sgp.Oie] at @s \
    run function sgp.majeurs:pco/cabane/check_if_inside with entity @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_cage_storage",nbt={data:{cage:"oie"}},limit=1] data.fill

execute as @a[team=sgp.Canard] at @s \
    run function sgp.majeurs:pco/cabane/check_if_inside with entity @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_cage_storage",nbt={data:{cage:"canard"}},limit=1] data.fill
