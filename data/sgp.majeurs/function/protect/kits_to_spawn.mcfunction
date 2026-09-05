#> sgp.majeurs:protect/kits_to_spawn
#
# Route a participant from kit selection to their Protect team spawn.

execute unless score #protect_phase sgp.dummy matches 2 run return 0
function sgp.majeurs:protect/update_glow
tp @s[team=sgp.bleue] @e[tag=sgp.marker,name="protect_spawn_bleus",limit=1,type=marker]
tp @s[team=sgp.rouge] @e[tag=sgp.marker,name="protect_spawn_rouges",limit=1,type=marker]
