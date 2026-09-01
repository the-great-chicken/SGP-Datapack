#> sgp.mineurs:initialization

# ---------- Create Objectives ----------

scoreboard objectives add sgp.reflexes_joueur trigger
scoreboard objectives add sgp.reward trigger
scoreboard objectives add sgp.share_item trigger



# ---------- Initialize Values ----------

scoreboard players set #confines_ticks sgp.timer 0
scoreboard players set #confines_secondes sgp.timer 0



# ---------- Misc ----------

time of sgp.mineurs:confinement_clock set 10000t
time of sgp.mineurs:confinement_clock pause



# ---------- Initialize Storages ----------

data merge storage sgp:data {"mineurs":{}}



# ---------- Init Marker UUIDs ----------

data remove storage sgp:data markers_lists.lootdrop
execute as @e[tag=sgp.marker,name="Lootdrop",type=marker] \
    run function sgp.misc:uuid_array_to_string/init {list_location:"markers_lists.lootdrop"}
