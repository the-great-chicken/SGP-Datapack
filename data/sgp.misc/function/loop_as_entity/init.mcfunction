#> sgp.misc:loop_as_entity/init
# `{list_location: nbt path, command: string}`

# 1. Copy the full list to a temporary array
$data modify storage sgp:data temp.loop_list set from storage sgp:data $(list_location)

# 2. Save the command globally so it persists across recursion steps
$data modify storage sgp:data temp.current_command set value "$(command)"

# 3. If the list isn't empty, prepare the arguments for the first run (merging uuid and command)
data modify storage sgp:data temp.run_args set from storage sgp:data temp.loop_list[0]
data modify storage sgp:data temp.run_args.command set from storage sgp:data temp.current_command

# 4. Start the loop
function sgp.misc:loop_as_entity/recursion with storage sgp:data temp.run_args