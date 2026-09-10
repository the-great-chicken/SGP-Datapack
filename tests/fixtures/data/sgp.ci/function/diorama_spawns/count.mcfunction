#> sgp.ci:diorama_spawns/count
# `{count: nonnegative int}`
#
# Count generated spawn buttons and labels and require the same expected total for both.

execute positioned 8.0 80.0 8.0 store result score #ci.menu.buttons sgp.dummy if entity @e[tag=sgp.spawn_tper,dx=7,dy=7,dz=7,type=interaction]
# Count labels throughout this fixture's model, including zero-size displays on its floor. The neighboring model is farther away.
execute positioned 8.0 80.0 8.0 store result score #ci.menu.labels sgp.dummy if entity @e[tag=sgp.spawn_tper_text,distance=..14,type=text_display]
$assert score #ci.menu.buttons sgp.dummy matches $(count)
$assert score #ci.menu.labels sgp.dummy matches $(count)
