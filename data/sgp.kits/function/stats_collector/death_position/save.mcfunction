#> sgp.kits:stats_collector/death_position/save
# `{dimension: dimension id, x: floor(x * 10), y: floor(y * 10), z: floor(z * 10)}`

scoreboard players set #death_position_total sgp.dummy 0
$execute store result score #death_position_total sgp.dummy \
    run data get storage sgp.kits:stats death_positions."$(dimension)"."$(x),$(y),$(z)"
scoreboard players add #death_position_total sgp.dummy 1
$execute store result storage sgp.kits:stats death_positions."$(dimension)"."$(x),$(y),$(z)" int 1 \
    run scoreboard players get #death_position_total sgp.dummy
