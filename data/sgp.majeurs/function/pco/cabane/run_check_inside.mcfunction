#> sgp.majeurs:pco/cabane/run_check_inside
# 
# Run the function to check if players are inside their cabane,
# and show them their remaining time in seconds.

scoreboard players operation @s sgp.temps_cabane_pco_secondes = @s sgp.temps_cabane_pco

scoreboard players operation @s sgp.temps_cabane_pco_secondes /= 100 sgp.dummy

function sgp.majeurs:pco/cabane/inside_actionbar


execute as @s[team=sgp.Poule] \
    at @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_poule_cage_arena",limit=1] \
        run function sgp.majeurs:pco/cabane/check_if_inside

execute as @s[team=sgp.Oie] \
    at @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_oie_cage_arena",limit=1] \
        run function sgp.majeurs:pco/cabane/check_if_inside

execute as @s[team=sgp.Canard] \
    at @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_canard_cage_arena",limit=1] \
        run function sgp.majeurs:pco/cabane/check_if_inside
