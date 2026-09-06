#> sgp.majeurs:pco/cabane/run_check_inside
#
# Refresh the player's refuge allowance and actionbar.

execute if entity @s[team=sgp.Oie] \
    at @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_poule_cage_arena",limit=1,type=marker] \
        run function sgp.majeurs:pco/cabane/check_if_inside

execute if entity @s[team=sgp.Canard] \
    at @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_oie_cage_arena",limit=1,type=marker] \
        run function sgp.majeurs:pco/cabane/check_if_inside

execute if entity @s[team=sgp.Poule] \
    at @e[tag=sgp.marker,tag=sgp.pco.active,name="pco_canard_cage_arena",limit=1,type=marker] \
        run function sgp.majeurs:pco/cabane/check_if_inside

scoreboard players operation @s sgp.temps_cabane_pco_secondes = @s sgp.temps_cabane_pco
scoreboard players operation @s sgp.temps_cabane_pco_secondes /= 100 sgp.dummy
function sgp.majeurs:pco/cabane/inside_actionbar
