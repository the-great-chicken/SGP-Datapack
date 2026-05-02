#> function sgp.misc:loop_as_entity/recursion
# `{uuid: entity uuid, command: "run kill @s"}`

# 1. Run the dynamic command directly as the entity!
$execute as $(uuid) at @s $(command)

# 2. Remove the processed element (Index 1 becomes the new Index 0)
data remove storage sgp:data temp.loop_list[0]

# 3. If there is still at least one element, prepare the arguments for the next run and recurse
execute unless data storage sgp:data temp.loop_list[0] run return 1

data modify storage sgp:data temp.run_args set from storage sgp:data temp.loop_list[0]
data modify storage sgp:data temp.run_args.command set from storage sgp:data temp.current_command
function sgp.misc:loop_as_entity/recursion with storage sgp:data temp.run_args