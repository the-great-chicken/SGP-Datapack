#> sgp.kits:stats_collector/maybe_save_ability_cooldown
# `{kit_id}`

$execute if data storage sgp.kits:stats kit_settings.$(kit_id).ability_cooldown \
    run return 0

$data modify storage sgp:macro stats.current_kit_cooldown.index set value $(kit_id)
data modify storage sgp:macro stats.current_kit_cooldown.function set value "sgp.kits:stats_collector/save_ability_cooldown"
data modify storage sgp:macro stats.current_kit_cooldown.list set value "sgp:kits kit_id_order"

function sgp.misc:run_with_dynamic_list_index \
    with storage sgp:macro stats.current_kit_cooldown