#> sgp.ci:locations/loop_marker
# `{index: int, x: int}`: one production-shaped location marker `x` blocks along +x, 1x3x1, width 10*index.
$function sgp.world:lieu/initialization {lieu:"test_loop_$(index)"}
$scoreboard players set @s sgp.lieu_test_loop_$(index) 0
$summon marker ~$(x) ~ ~ {CustomName:"lieu",Tags:["sgp.marker","sgp.test.location_loop","sgp.test.location_loop_$(index)"],data:{lieu:"test_loop_$(index)",lieu_propre:"Test loop $(index)",couleur:"white",width:$(index)0,dx:1,dy:3,dz:1}}
