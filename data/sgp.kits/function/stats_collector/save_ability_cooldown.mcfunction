#> sgp.kits:stats_collector/save_ability_cooldown
# `{kit_id, ability_path}`

$execute store result storage sgp.kits:stats kit_settings.$(kit_id).ability_cooldown int 1 \
    run data get storage sgp:data kits.ability_cooldowns.$(ability_path).cooldown