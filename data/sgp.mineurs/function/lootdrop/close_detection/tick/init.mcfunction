#> sgp.mineurs:lootdrop/close_detection/tick/init
# 
# Checks if the chest was closed by looking if the LootTable is present on it.
execute store success score #was_chest_closed sgp.dummy \
    as @e[type=marker,tag=sgp.marker,name="Lootdrop"] at @s \
        if block ~ ~ ~ trapped_chest \
            if data block ~ ~ ~ LootTable

execute if score #was_chest_closed sgp.dummy matches \
    1 as @e[type=marker,tag=sgp.marker,name="Lootdrop"] at @s \
        if block ~ ~ ~ trapped_chest \
            run function sgp.mineurs:lootdrop/close_detection/tick/closed

execute if score #was_chest_closed sgp.dummy matches \
    1 run return 0


# Revoke tick advancement so it runs the next tick as well.
advancement revoke @s only sgp.mineurs:tick