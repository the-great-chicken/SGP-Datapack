#> sgp.majeurs:pco/check_death
#
# Check if someone is back to the kits room, and if so,
# run the function corresponding to its team to get him back in the game

execute at @e[type=marker,tag=sgp.marker,name="kits",limit=1] \
    as @a[distance=..3,team=sgp.Poule] \
        run function sgp.majeurs:pco/on_death {color:red, color_hex:16733525, color_material:redstone, team:Poule}

execute at @e[type=marker,tag=sgp.marker,name="kits",limit=1] \
    as @a[distance=..3,team=sgp.Canard] \
        run function sgp.majeurs:pco/on_death {color:green, color_hex:5635925, color_material:emerald, team:Canard}
        
execute at @e[type=marker,tag=sgp.marker,name="kits",limit=1] \
    as @a[distance=..3,team=sgp.Oie] \
        run function sgp.majeurs:pco/on_death {color:yellow, color_hex:16777045, color_material:gold, team:Oie}