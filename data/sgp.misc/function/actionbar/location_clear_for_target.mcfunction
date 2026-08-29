#> sgp.misc:actionbar/location_clear_for_target
# `{lieu: string}`
#
# Called as a location marker while actionbar/clear temporarily marks the
# player whose SGP-owned location segments must be removed.

$execute as @a[tag=sgp.ab.location_clear_target] run function sgp.misc:actionbar/location_clear {lieu:"$(lieu)"}
