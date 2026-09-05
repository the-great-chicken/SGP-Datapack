#> sgp.majeurs:pco/on_start
# `{color, color_material, color_hex, team, to_catch, color_team, color_to_catch}`
#
# Equip one participant and establish their team glow view.

$function sgp.majeurs:pco/kit {color:"$(color)", color_material:"$(color_material)", color_hex:"$(color_hex)"}

$glow add @s @a[team=sgp.$(team)] $(color_team)
$glow add @s @a[team=sgp.$(to_catch)] $(color_to_catch)
