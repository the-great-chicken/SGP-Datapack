#> sgp.cosmetics:grants/player_isolation
# @dummy
# @environment sgp.ci:cosmetics
#
# A cosmetic grant only unlocks the recipient, and another player can be granted access independently.

function sgp.ci:cosmetic_grants/lock_choices
dummy GrantPeer spawn
execute as GrantPeer run function sgp.ci:cosmetic_grants/lock_choices
function sgp.cosmetics:unlock_all_cosmetics
execute as GrantPeer run function sgp.ci:cosmetic_grants/select_choices
assert entity @a[name=GrantPeer,tag=!sgp.particle.marine,tag=!sgp.intensity.super_heavy,tag=!sgp.kill.firework]
assert not score GrantPeer sgp.particle.marine_unlocked matches 1
assert score GrantPeer sgp.intensity.super_heavy_unlocked matches 0
assert score GrantPeer sgp.kill.firework_unlocked matches 0
function sgp.ci:cosmetic_grants/select_choices
execute as GrantPeer run function sgp.cosmetics:unlock_all_cosmetics
execute as GrantPeer run function sgp.ci:cosmetic_grants/select_choices
assert entity @a[name=GrantPeer,tag=sgp.particle.marine,tag=sgp.intensity.super_heavy,tag=sgp.kill.firework]
assert entity @s[tag=sgp.particle.marine,tag=sgp.intensity.super_heavy,tag=sgp.kill.firework]
dummy GrantPeer leave
