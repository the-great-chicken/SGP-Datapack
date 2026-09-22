#> sgp.kits:stats_collector/collect_ray_damage_received_valid
#
# Fast path for a validated Rays damage event. Rays only target non-peaceful players other
# than the caster, and their damage source is always that caster, whose ids and cast were
# captured once per tick by ability/ray_caster_context.
scoreboard players operation #damage_received_delta sgp.dummy = @s sgp.damage_taken
execute store result storage sgp:macro stats.current_damage_info.id_target int 1 \
    run scoreboard players get @s sgp.id
execute store result storage sgp:macro stats.current_damage_info.kit_id_target int 1 \
    run scoreboard players get @s sgp.kit_id
execute if score #ray_ability_cast sgp.dummy matches 1.. \
    run function sgp.kits:stats_collector/ability/mark_ray_affected with storage sgp:macro stats.current_damage_info
function sgp.kits:stats_collector/save_damage_received with storage sgp:macro stats.current_damage_info
