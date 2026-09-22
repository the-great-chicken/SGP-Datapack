#> sgp.kits:bats/detonation_coalescing_boundaries
# @dummy
# @environment sgp.ci:bats_detonation
#
# Coalescing must not consume a nearby bat from another owner/cast, a bat beyond
# the overlap radius, or a nearby bat that does not independently have a target.

summon mannequin ~ ~1 ~ {Tags:["sgp.illusion","sgp.ci.bat_guard_target"],Invulnerable:1b}

# Leader: valid target, owner 100, cast 7.
summon bat ~2.4 ~1 ~ {Tags:["sgp.bat_grenade","sgp.ci.bat_guard","sgp.ci.bat_boundary_leader"],NoAI:1b,NoGravity:1b}
scoreboard players set @e[tag=sgp.ci.bat_boundary_leader,limit=1,type=bat] sgp.damage_owner 100
scoreboard players set @e[tag=sgp.ci.bat_boundary_leader,limit=1,type=bat] sgp.ability_cast 7

# Within 0.5 blocks, but outside the target's 2.5-block trigger radius.
summon bat ~2.8 ~1 ~ {Tags:["sgp.bat_grenade","sgp.ci.bat_guard","sgp.ci.bat_no_target"],NoAI:1b,NoGravity:1b}
scoreboard players set @e[tag=sgp.ci.bat_no_target,limit=1,type=bat] sgp.damage_owner 100
scoreboard players set @e[tag=sgp.ci.bat_no_target,limit=1,type=bat] sgp.ability_cast 7

# Close and target-valid, but belongs to another cast.
summon bat ~2.2 ~1 ~ {Tags:["sgp.bat_grenade","sgp.ci.bat_guard","sgp.ci.bat_other_cast"],NoAI:1b,NoGravity:1b}
scoreboard players set @e[tag=sgp.ci.bat_other_cast,limit=1,type=bat] sgp.damage_owner 100
scoreboard players set @e[tag=sgp.ci.bat_other_cast,limit=1,type=bat] sgp.ability_cast 8

# Close and target-valid, but belongs to another owner.
summon bat ~2.3 ~1 ~ {Tags:["sgp.bat_grenade","sgp.ci.bat_guard","sgp.ci.bat_other_owner"],NoAI:1b,NoGravity:1b}
scoreboard players set @e[tag=sgp.ci.bat_other_owner,limit=1,type=bat] sgp.damage_owner 101
scoreboard players set @e[tag=sgp.ci.bat_other_owner,limit=1,type=bat] sgp.ability_cast 7

# Same owner/cast and target-valid, but outside the 0.5-block coalescing radius.
summon bat ~1.8 ~1 ~ {Tags:["sgp.bat_grenade","sgp.ci.bat_guard","sgp.ci.bat_outside_cluster"],NoAI:1b,NoGravity:1b}
scoreboard players set @e[tag=sgp.ci.bat_outside_cluster,limit=1,type=bat] sgp.damage_owner 100
scoreboard players set @e[tag=sgp.ci.bat_outside_cluster,limit=1,type=bat] sgp.ability_cast 7

execute as @e[tag=sgp.ci.bat_boundary_leader,limit=1,type=bat] at @s run function sgp.kits:abilities/bats/explode
assert entity @e[tag=sgp.ci.bat_boundary_leader,tag=sgp.bat_detonated,type=bat]
assert not entity @e[tag=sgp.ci.bat_no_target,tag=sgp.bat_detonated,type=bat]
assert not entity @e[tag=sgp.ci.bat_other_cast,tag=sgp.bat_detonated,type=bat]
assert not entity @e[tag=sgp.ci.bat_other_owner,tag=sgp.bat_detonated,type=bat]
assert not entity @e[tag=sgp.ci.bat_outside_cluster,tag=sgp.bat_detonated,type=bat]
