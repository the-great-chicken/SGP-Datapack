# Runtime cleanup only; existing LuckPerms groups/memberships are not deleted.
execute as @e[tag=sgp.marker,name="lieu",type=marker] run function sgp.integration.tab:location/remove_applied_tag_for_all with entity @s data
scoreboard objectives remove sgp.tab_dirty
scoreboard objectives remove sgp.tab_candidate
scoreboard objectives remove sgp.tab_applied
scoreboard objectives remove sgp.kit_prefix_set
tag @a remove sgp.tab_target
