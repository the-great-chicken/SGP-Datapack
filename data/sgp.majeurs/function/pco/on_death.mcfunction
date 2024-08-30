#> sgp.majeurs:pco/on_death
# `{color, color_material, color_hex, cage, team, to_catch, color_team, color_to_catch}`
#
# Execute actions when a players dies, according to their team.

$function sgp.majeurs:pco/on_start {color:$(color), color_material:$(color_material), color_hex:$(color_hex), team:$(team), to_catch:$(to_catch), color_team:$(color_team), color_to_catch:$(color_to_catch)}
$tp @s @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_spawn_cage_$(team)",limit=1]