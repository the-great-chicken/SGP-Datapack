#> sgp.cosmetics:grants/preserve_selection
# @dummy
# @environment sgp.ci:cosmetics
#
# Granting access, including repeated grants, preserves the currently equipped cosmetics.

function sgp.ci:cosmetic_grants/lock_choices
scoreboard players set @s sgp.particle.smoke_unlocked 1
scoreboard players set @s sgp.intensity.light_unlocked 1
scoreboard players set @s sgp.kill.anvil_unlocked 1
function sgp.cosmetics:particles/reset_and_replace {particle:smoke,particle_name:"Smoke",color:gray}
function sgp.cosmetics:particles/reset_and_replace_intensity {intensity:light,intensity_name:"Light",color:white}
function sgp.cosmetics:kill_effects/reset_and_replace {kill:anvil,kill_name:"Anvil",color:gray}
function sgp.cosmetics:unlock_all_cosmetics
function sgp.cosmetics:unlock_all_cosmetics
assert entity @s[tag=sgp.particle.smoke,tag=sgp.intensity.light,tag=sgp.kill.anvil]
assert not entity @s[tag=sgp.particle.marine]
assert not entity @s[tag=sgp.intensity.super_heavy]
assert not entity @s[tag=sgp.kill.firework]
# Newly available selections still replace the old choices normally.
function sgp.ci:cosmetic_grants/select_choices
assert entity @s[tag=sgp.particle.marine,tag=sgp.intensity.super_heavy,tag=sgp.kill.firework]
assert not entity @s[tag=sgp.particle.smoke]
assert not entity @s[tag=sgp.intensity.light]
assert not entity @s[tag=sgp.kill.anvil]
