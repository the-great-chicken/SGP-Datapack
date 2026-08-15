#> sgp.mineurs:frenzy/cooldowns/apply
# `{key: <SNBT key token>}`

$execute store result storage sgp:data kits.ability_cooldowns.$(key).cooldown short 0.5 \
    run data get storage sgp:data kits.ability_cooldowns.$(key).cooldown

# Consume this key from the disposable copy. Failure would otherwise recurse forever.
$execute store success score #haste.remove_ok sgp.dummy \
    run data remove storage sgp:data mineurs.haste.walker.remaining.$(key)
execute unless score #haste.remove_ok sgp.dummy matches 1 \
    run return run function sgp.mineurs:frenzy/stop

# Process the next key.
data modify storage sgp:data mineurs.haste.walker.next.value set from storage sgp:data mineurs.haste.walker.remaining
function sgp.mineurs:frenzy/cooldowns/next with storage sgp:data mineurs.haste.walker.next
