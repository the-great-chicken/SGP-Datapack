#> sgp.majeurs:pco/on_death
# `{color, color_material, color_hex, cage, team, to_catch, color_team, color_to_catch}`
#
# Executes actions when a players dies, according to their team.

$function sgp.majeurs:pco/kit {color:$(color), color_material:$(color_material), color_hex:$(color_hex)}
effect give @s resistance infinite 5 true
$execute at @e[type=marker,tag=sgp.marker,name="pco_$(cage)_cage_arena",limit=1] run tp @s ~1 ~ ~1
$targetglow @s @a[gamemode=survival,team=sgp.$(team)] $(color_team)
$targetglow @s @a[gamemode=survival,team=sgp.$(to_catch)] $(color_to_catch)