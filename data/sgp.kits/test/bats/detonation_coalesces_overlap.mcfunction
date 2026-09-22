#> sgp.kits:bats/detonation_coalesces_overlap
# @dummy
# @environment sgp.ci:bats_detonation
#
# Same-owner, same-cast grenade bats that independently have a target and whose
# centers overlap closely share one physical explosion.

summon mannequin ~ ~1 ~ {Tags:["sgp.illusion","sgp.ci.bat_guard_target"],Invulnerable:1b}
summon bat ~ ~1 ~ {Tags:["sgp.bat_grenade","sgp.ci.bat_guard","sgp.ci.bat_cluster_leader"],NoAI:1b,NoGravity:1b}
summon bat ~0.3 ~1 ~ {Tags:["sgp.bat_grenade","sgp.ci.bat_guard","sgp.ci.bat_cluster_follower"],NoAI:1b,NoGravity:1b}
scoreboard players set @e[tag=sgp.ci.bat_cluster_leader,limit=1,type=bat] sgp.damage_owner 999999
scoreboard players set @e[tag=sgp.ci.bat_cluster_follower,limit=1,type=bat] sgp.damage_owner 999999
scoreboard players set @e[tag=sgp.ci.bat_cluster_leader,limit=1,type=bat] sgp.ability_cast 7
scoreboard players set @e[tag=sgp.ci.bat_cluster_follower,limit=1,type=bat] sgp.ability_cast 7
execute as @e[tag=sgp.ci.bat_cluster_leader,limit=1,type=bat] at @s run function sgp.kits:abilities/bats/explode
execute as @e[tag=sgp.ci.bat_cluster_follower,limit=1,type=bat] at @s run function sgp.kits:abilities/bats/explode
execute store result score #ci.bat_guard.count sgp.dummy if entity @e[tag=sgp.bat_grenade,type=tnt]
assert score #ci.bat_guard.count sgp.dummy matches 1
assert entity @e[tag=sgp.ci.bat_cluster_leader,tag=sgp.bat_detonated,type=bat]
assert entity @e[tag=sgp.ci.bat_cluster_follower,tag=sgp.bat_detonated,type=bat]
