#> sgp.majeurs:pco/check_death
#
# Send newly respawned players to their active location-set cage.

execute at @e[tag=sgp.marker,name="respawn",limit=1,type=marker] \
    as @a[distance=..3,team=sgp.Poule,tag=!sgp.pco.awaiting_cage] \
        run function sgp.majeurs:pco/on_death {color:red, color_hex:16733525, color_material:redstone, team:Poule}

execute at @e[tag=sgp.marker,name="respawn",limit=1,type=marker] \
    as @a[distance=..3,team=sgp.Canard,tag=!sgp.pco.awaiting_cage] \
        run function sgp.majeurs:pco/on_death {color:green, color_hex:5635925, color_material:emerald, team:Canard}

execute at @e[tag=sgp.marker,name="respawn",limit=1,type=marker] \
    as @a[distance=..3,team=sgp.Oie,tag=!sgp.pco.awaiting_cage] \
        run function sgp.majeurs:pco/on_death {color:yellow, color_hex:16777045, color_material:gold, team:Oie}
