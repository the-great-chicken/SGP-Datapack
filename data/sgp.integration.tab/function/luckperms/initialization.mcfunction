#> sgp.integration.tab:luckperms/initialization
# Load-time setup is intentionally submitted as a bounded burst. LuckPerms
# queues it internally; runtime user mutations remain limited to one per tick.

# 40 kit commands + one location-track command + three commands per location,
# plus a five-tick safety margin before runtime mutations begin.
scoreboard players set #tab_init_wait sgp.dummy 46
scoreboard players set #tab_location_count sgp.dummy 0
execute store result score #tab_location_count sgp.dummy if entity @e[type=marker,tag=sgp.marker,name="lieu"]
scoreboard players operation #tab_location_count sgp.dummy *= 3 sgp.dummy
scoreboard players operation #tab_init_wait sgp.dummy += #tab_location_count sgp.dummy
scoreboard players set #tab_init_done sgp.dummy 0
scoreboard players set @a sgp.tab_dirty 5

# ---------- Kit groups and prefixes ----------
luckperms creategroup alchimiste
luckperms creategroup enderman
luckperms creategroup pigeon
luckperms creategroup poseidon
luckperms creategroup cancer
luckperms creategroup eclaireur
luckperms creategroup roi
luckperms creategroup tank
luckperms creategroup pyromane
luckperms creategroup combattant
luckperms creategroup archer
luckperms creategroup vindicateur
luckperms creategroup peaceful

luckperms group alchimiste meta setprefix 0 &d
luckperms group enderman meta setprefix 0 &5
luckperms group pigeon meta setprefix 0 &f&7
luckperms group poseidon meta setprefix 0 &3
luckperms group cancer meta setprefix 0 &4
luckperms group eclaireur meta setprefix 0 &b
luckperms group roi meta setprefix 0 &f&e
luckperms group tank meta setprefix 0 &1
luckperms group pyromane meta setprefix 0 &f&6
luckperms group combattant meta setprefix 0 &f
luckperms group archer meta setprefix 0 &a
luckperms group vindicateur meta setprefix 0 &2
luckperms group peaceful meta setprefix 0 &c❤

luckperms createtrack kit
luckperms track kit append alchimiste
luckperms track kit append enderman
luckperms track kit append pigeon
luckperms track kit append poseidon
luckperms track kit append cancer
luckperms track kit append eclaireur
luckperms track kit append roi
luckperms track kit append tank
luckperms track kit append pyromane
luckperms track kit append combattant
luckperms track kit append archer
luckperms track kit append vindicateur
luckperms track kit append peaceful

# ---------- Location groups and suffixes ----------
luckperms createtrack sgp-location

# Traverse the UUID list without `execute as`, so every LuckPerms command keeps
# the server command source used by the load function.
data modify storage sgp:macro tab.location_setup_markers set value []
data modify storage sgp:macro tab.location_setup_markers set from storage sgp:data markers_lists.location
function sgp.integration.tab:luckperms/setup_locations
