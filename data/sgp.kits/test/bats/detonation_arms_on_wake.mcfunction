#> sgp.kits:bats/detonation_arms_on_wake
# @dummy
# @environment sgp.ci:bats_detonation
#
# The per-cast wake preserves the exact one-second minimum fuse even while the
# shared follow-up loop is free to scan other, older grenade bats.

summon mannequin ~ ~1 ~ {Tags:["sgp.illusion","sgp.ci.bat_guard_target"],Invulnerable:1b}
execute store result score #ci.bat_now sgp.dummy run time query gametime
summon bat ~ ~1 ~ {Tags:["sgp.bat_grenade","sgp.ci.bat_guard","sgp.ci.bat_wake"],NoAI:1b,NoGravity:1b}
scoreboard players operation @e[tag=sgp.ci.bat_wake,limit=1,type=bat] sgp.bat_arm_at = #ci.bat_now sgp.dummy
scoreboard players add @e[tag=sgp.ci.bat_wake,limit=1,type=bat] sgp.bat_arm_at 20
scoreboard players set @e[tag=sgp.ci.bat_wake,limit=1,type=bat] sgp.damage_owner 100
scoreboard players set @e[tag=sgp.ci.bat_wake,limit=1,type=bat] sgp.ability_cast 1

schedule function sgp.kits:abilities/bats/check_for_explosion 20t append
await delay 19t
assert not entity @e[tag=sgp.ci.bat_wake,tag=sgp.bat_detonated,type=bat]
await delay 1t
assert entity @e[tag=sgp.ci.bat_wake,tag=sgp.bat_detonated,type=bat]
