#> sgp.ci:interaction_dispatch/record_click
# `{target: first|second}`
#
# Supply vanilla's interaction record before calling the advancement reward entry point.
# Minecraft discards incomplete interaction records when loading entity NBT.

data modify storage sgp.ci:interaction_dispatch click set value {timestamp:1L}
data modify storage sgp.ci:interaction_dispatch click.player set from entity @s UUID
$data modify entity @n[tag=sgp.ci.interaction_$(target),type=interaction] interaction set from storage sgp.ci:interaction_dispatch click
$assert data entity @n[tag=sgp.ci.interaction_$(target),type=interaction] interaction{timestamp:1L}
