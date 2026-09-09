#> sgp.ci:diorama_spawns/count
# {count}
execute positioned 8.0 80.0 8.0 store result score #ci.menu.buttons sgp.dummy if entity @e[tag=sgp.spawn_tper,dx=7,dy=7,dz=7,type=interaction]
execute positioned 8.0 80.0 8.0 store result score #ci.menu.labels sgp.dummy if entity @e[tag=sgp.spawn_tper_text,dx=7,dy=7,dz=7,type=text_display]
$assert score #ci.menu.buttons sgp.dummy matches $(count)
$assert score #ci.menu.labels sgp.dummy matches $(count)
