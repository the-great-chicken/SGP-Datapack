#> sgp.kits:uninstall

# ---------- Remove Objectives ----------

scoreboard objectives remove sgp.pyromane_found
scoreboard objectives remove sgp.cancer_found
scoreboard objectives remove sgp.roi_found
scoreboard objectives remove sgp.pigeon_found
scoreboard objectives remove sgp.tank_found
scoreboard objectives remove sgp.enderman_found
scoreboard objectives remove sgp.alchimiste_found
scoreboard objectives remove sgp.poseidon_found
scoreboard objectives remove sgp.eclaireur_found
scoreboard objectives remove sgp.peaceful_found

scoreboard objectives remove sgp.cooldown_ability
scoreboard objectives remove sgp.duration_ability
scoreboard objectives remove sgp.trigger_repulsion
scoreboard objectives remove sgp.cooldown_water_trident
scoreboard objectives remove sgp.drop_any
execute as @e[tag=sgp.marker,name="abilities_shulker",type=marker] run setblock ~ ~ ~ air
scoreboard objectives remove sgp.current_attack_damage
scoreboard objectives remove sgp.pecking_timer

scoreboard objectives remove sgp.old_x
scoreboard objectives remove sgp.old_y
scoreboard objectives remove sgp.old_z
scoreboard objectives remove sgp.dx
scoreboard objectives remove sgp.dy
scoreboard objectives remove sgp.dz

scoreboard objectives remove sgp.kills_give_1
scoreboard objectives remove sgp.kills_give_2
scoreboard objectives remove sgp.kills_give_3

scoreboard objectives remove sgp.kit_id
scoreboard objectives remove sgp.kit_prefix_set
scoreboard objectives remove sgp.reset_tags

scoreboard objectives remove sgp.last_kill_count
scoreboard objectives remove sgp.death_cause
scoreboard objectives remove sgp.damage_taken
scoreboard objectives remove sgp.damage_owner
scoreboard objectives remove sgp.damage_resisted
scoreboard objectives remove sgp.ability_cast
scoreboard objectives remove sgp.ability_kind
scoreboard objectives remove sgp.ability_success
scoreboard objectives remove sgp.last_ability_cast
scoreboard objectives remove sgp.ability_result_window
scoreboard objectives remove sgp.peck_lock_ticks

scoreboard objectives remove sgp.elo
scoreboard objectives remove sgp.elo_pending
scoreboard objectives remove sgp.elo_encounters
scoreboard objectives remove sgp.elo_deaths
scoreboard objectives remove sgp.elo_deaths_seen



# ---------- Remove Teams ----------

team remove sgp.Illusion



# ---------- Clear Schedules ----------

schedule clear sgp.kits:kit_tags/prefixes_check



# ---------- Remove Storages ----------

data remove storage sgp.kits:stats kits_dict
data remove storage sgp.kits:stats damage_cause_names
data remove storage sgp.kits:stats ability_metadata
data remove storage sgp.kits:stats elo_metadata
data remove storage sgp.kits:stats elo_ratings
data remove storage sgp.kits:stats schema_version
data remove storage sgp.kits:runtime elo_delta_lookup



# ---------- Remove Tags ----------

tag @a remove sgp.ability_damage_target
tag @a remove sgp.stats_pecking_active
tag @a remove sgp.stats_tank_boost_active
tag @a remove sgp.current_damage_owner
tag @a remove sgp.elo_victim
tag @a remove sgp.elo_touched
