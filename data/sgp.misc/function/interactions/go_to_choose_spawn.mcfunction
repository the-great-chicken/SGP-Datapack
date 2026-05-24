#> sgp.misc:interactions/go_to_choose_spawn
# `{spawns:[{x, y, z, yaw, pitch}]: coordinates list}`
#
# Tp to place to choose spawnpoint, except if confinement is running (then tp to a random confinement spawn)

execute if score #confines_secondes sgp.timer matches 1.. run return run tp @s @e[tag=sgp.marker,name="Confinement",limit=1,sort=random,type=marker] 

execute if entity @a[predicate=sgp.majeurs:event_in_progress] run return run function sgp.majeurs:common/kits_to_spawn

$data modify storage sgp:macro spawns_select.spawns set value $(spawns)
data modify storage sgp:macro spawns_select.function set value "sgp.misc:interactions/simple_tp"
data modify storage sgp:macro spawns_select.list set value "sgp:macro spawns_select.spawns"

execute store result score #spawn_count sgp.dummy \
    run data get storage sgp:macro spawns_select.spawns
execute store result storage sgp:macro spawns_select.max int 1 \
    run scoreboard players remove #spawn_count sgp.dummy 1

execute store result storage sgp:macro spawns_select.index int 1 \
    run function sgp.misc:random_value with storage sgp:macro spawns_select

function sgp.misc:run_with_dynamic_list_index with storage sgp:macro spawns_select

data remove storage sgp:macro spawns_select