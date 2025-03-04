#> sgp.majeurs:pco/on_start
# `{color, color_material, color_hex, cage, team, to_catch, color_team, color_to_catch}`
#
# Execute actions when a players dies, according to their team.

$function sgp.majeurs:pco/kit {color:"$(color)", color_material:"$(color_material)", color_hex:"$(color_hex)"}

$targetglow @s @a[team=sgp.$(team)] $(color_team)
$targetglow @s @a[team=sgp.$(to_catch)] $(color_to_catch)