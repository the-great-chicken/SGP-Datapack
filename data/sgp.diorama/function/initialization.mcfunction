#> sgp.diorama:initialization

# ---------- Create Objectives ----------

scoreboard objectives add sgp.anim_timer dummy



# ---------- Initialize Values ----------

scoreboard players add #mannequins_swing_enabled sgp.dummy 0
scoreboard players set #mannequin_update_time sgp.dummy 0



# ---------- Enable and Init Diorama ----------

scoreboard players set #diorama_enabled sgp.dummy 0
execute if entity @e[tag=sgp.marker,name="playable_map_model",limit=1,type=marker] \
    run scoreboard players set #diorama_enabled sgp.dummy 1

execute if score #diorama_enabled sgp.dummy matches 1 \
    run function sgp.diorama:init/markers

execute if score #diorama_enabled sgp.dummy matches 1 \
    as @e[tag=sgp.marker,name=playable_map_model,type=marker] at @s \
        run function sgp.diorama:spawn_entities/clear_and_recreate \
            with entity @s data