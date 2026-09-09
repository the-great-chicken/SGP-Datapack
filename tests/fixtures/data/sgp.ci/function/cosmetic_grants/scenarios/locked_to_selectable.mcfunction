#> sgp.ci:cosmetic_grants/scenarios/locked_to_selectable

function sgp.ci:cosmetic_grants/lock_choices
function sgp.ci:cosmetic_grants/select_choices
assert not entity @s[tag=sgp.particle.marine]
assert not entity @s[tag=sgp.intensity.super_heavy]
assert not entity @s[tag=sgp.kill.firework]
function sgp.cosmetics:unlock_all_cosmetics
assert not entity @s[tag=sgp.particle.marine]
assert not entity @s[tag=sgp.intensity.super_heavy]
assert not entity @s[tag=sgp.kill.firework]
function sgp.ci:cosmetic_grants/select_choices
assert entity @s[tag=sgp.particle.marine,tag=sgp.intensity.super_heavy,tag=sgp.kill.firework]
