# Extracted from data/sgp.majeurs/function/pco/on_start.mcfunction; preserves caller execution context.
# Macro arguments: color_team, color_to_catch, team, to_catch.
$glow add @s @a[team=sgp.$(team)] $(color_team)
$glow add @s @a[team=sgp.$(to_catch)] $(color_to_catch)
