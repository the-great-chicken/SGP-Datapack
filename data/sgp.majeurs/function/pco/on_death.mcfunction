#> sgp.majeurs:pco/on_death
# `{color, color_material, color_hex, cage, team}`
#
# Execute actions when a players dies, according to their team.

$function sgp.majeurs:pco/kit {color:"$(color)", color_material:"$(color_material)", color_hex:"$(color_hex)"}

effect give @s resistance infinite 5 true

$function #bs.schedule:schedule {with:{command:"tp @s @e[type=marker,tag=sgp.marker,tag=sgp.enabled,name='pco_spawn_cage_$(team)',limit=1]",time:1,unit:"t"}}