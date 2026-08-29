#> sgp.world:uninstall

# ---------- Remove Objectives ----------

execute as @e[type=marker,tag=sgp.marker,name="lieu"] run function sgp.world:lieu/uninstallation with entity @s data

scoreboard objectives remove sgp.teleporteur
scoreboard objectives remove sgp.lieu_count

# ---------- Remove Storages -----------

data remove storage sgp:data markers_lists.location
data remove storage sgp:data markers_lists.teleporter