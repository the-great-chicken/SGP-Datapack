#> sgp.majeurs:pco/on_death
# `{color, color_material, color_hex, cage, team}`
#
# Execute actions when a players dies, according to their team.

$function sgp.majeurs:pco/kit {color:"$(color)", color_material:"$(color_material)", color_hex:"$(color_hex)"}
$tp @s @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name="pco_spawn_cage_$(team)",limit=1]