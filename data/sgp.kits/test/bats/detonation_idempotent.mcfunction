
#> sgp.kits:bats/detonation_idempotent
# @dummy
# @environment sgp.ci:bats_detonation
#
# Calling the detonation path twice for one bat in the same tick creates only
# one fuse-0 TNT.

summon bat ~ ~1 ~ {Tags:["sgp.bat_grenade","sgp.ci.bat_guard"],NoAI:1b,NoGravity:1b}
scoreboard players set @e[tag=sgp.ci.bat_guard,limit=1,type=bat] sgp.damage_owner 999999
scoreboard players set @e[tag=sgp.ci.bat_guard,limit=1,type=bat] sgp.ability_cast 1
execute as @e[tag=sgp.ci.bat_guard,limit=1,type=bat] at @s run function sgp.kits:abilities/bats/explode
execute as @e[tag=sgp.ci.bat_guard,limit=1,type=bat] at @s run function sgp.kits:abilities/bats/explode
execute as @e[tag=sgp.bat_grenade,type=tnt] run tag @s add sgp.ci.bat_guard_tnt
execute store result score #ci.bat_guard.count sgp.dummy if entity @e[tag=sgp.ci.bat_guard_tnt,type=tnt]
assert score #ci.bat_guard.count sgp.dummy matches 1
assert entity @e[tag=sgp.ci.bat_guard,tag=sgp.bat_detonated,type=bat]
