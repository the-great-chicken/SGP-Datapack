#> sgp.kits:abilities/fangs/summon_owned
# Executed as the Vindicateur at the final fang position.

# The owner UUID comes from the per-player cache: reading it from the player entity cost ~40 µs per fang.
function sgp.misc:player_uuid/to_macro
function sgp.kits:abilities/fangs/summon_owned_macro with storage sgp:macro owner
