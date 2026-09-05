#> sgp.world:initialization

# Entry order belongs to core location tracking, including the actionbar.
execute unless score #tab_location_serial sgp.dummy matches -2147483648..2147483647 run scoreboard players set #tab_location_serial sgp.dummy 1000000

# ---------- Create Objectives ----------

execute as @e[type=marker,tag=sgp.marker,name="lieu"] run function sgp.world:lieu/initialization with entity @s data

scoreboard objectives add sgp.teleporteur dummy
scoreboard objectives add sgp.lieu_count dummy



# ---------- Init Marker UUIDs ----------

data remove storage sgp:data markers_lists.location
execute as @e[tag=sgp.marker,name="lieu",type=marker] \
    run function sgp.misc:uuid_array_to_string/init {list_location:"markers_lists.location"}

data remove storage sgp:data markers_lists.teleporter
execute as @e[tag=sgp.marker,name="teleporter",type=marker] \
    run function sgp.misc:uuid_array_to_string/init {list_location:"markers_lists.teleporter"}