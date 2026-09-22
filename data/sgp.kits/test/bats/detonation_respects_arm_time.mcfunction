#> sgp.kits:bats/detonation_respects_arm_time
# @dummy
# @environment sgp.ci:bats_detonation
#
# A shared scan may see bats from several casts. Only bats whose own one-second
# arming timestamp has elapsed are eligible to detonate.

summon mannequin ~ ~1 ~ {Tags:["sgp.illusion","sgp.ci.bat_guard_target"],Invulnerable:1b}
execute store result score #ci.bat_now sgp.dummy run time query gametime

summon bat ~ ~1 ~ {Tags:["sgp.bat_grenade","sgp.ci.bat_guard","sgp.ci.bat_due"],NoAI:1b,NoGravity:1b}
summon bat ~0.4 ~1 ~ {Tags:["sgp.bat_grenade","sgp.ci.bat_guard","sgp.ci.bat_future"],NoAI:1b,NoGravity:1b}
scoreboard players operation @e[tag=sgp.ci.bat_due,limit=1,type=bat] sgp.bat_arm_at = #ci.bat_now sgp.dummy
scoreboard players operation @e[tag=sgp.ci.bat_future,limit=1,type=bat] sgp.bat_arm_at = #ci.bat_now sgp.dummy
scoreboard players add @e[tag=sgp.ci.bat_future,limit=1,type=bat] sgp.bat_arm_at 20
scoreboard players set @e[tag=sgp.ci.bat_due,limit=1,type=bat] sgp.damage_owner 100
scoreboard players set @e[tag=sgp.ci.bat_future,limit=1,type=bat] sgp.damage_owner 101
scoreboard players set @e[tag=sgp.ci.bat_due,limit=1,type=bat] sgp.ability_cast 1
scoreboard players set @e[tag=sgp.ci.bat_future,limit=1,type=bat] sgp.ability_cast 2

function sgp.kits:abilities/bats/scan_for_explosion
assert entity @e[tag=sgp.ci.bat_due,tag=sgp.bat_detonated,type=bat]
assert not entity @e[tag=sgp.ci.bat_future,tag=sgp.bat_detonated,type=bat]
