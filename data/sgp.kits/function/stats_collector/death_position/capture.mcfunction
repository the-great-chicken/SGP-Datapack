#> sgp.kits:stats_collector/death_position/capture
#
# Capture the executing player's feet position in tenths of a block. The
# integer result of `data get ... 10` uses floor quantization, including for
# negative coordinates.

data modify storage sgp:macro stats.current_death_position set value {}
data modify storage sgp:macro stats.current_death_position.dimension set from entity @s Dimension
execute store result storage sgp:macro stats.current_death_position.x int 1 \
    run data get entity @s Pos[0] 10
execute store result storage sgp:macro stats.current_death_position.y int 1 \
    run data get entity @s Pos[1] 10
execute store result storage sgp:macro stats.current_death_position.z int 1 \
    run data get entity @s Pos[2] 10

function sgp.kits:stats_collector/death_position/save with storage sgp:macro stats.current_death_position
data remove storage sgp:macro stats.current_death_position
