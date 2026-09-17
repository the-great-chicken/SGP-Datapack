
#> sgp.bench:scenarios/abilities/assassinate_triggered/teardown
# `{first: int, last: int, players: int, period: int}`

schedule clear sgp.kits:abilities/assassinate/rotate_delayed
execute as @e[tag=sgp.bench.assassin_attacker,type=husk] at @s run fill ~ ~ ~-2 ~ ~3 ~-2 minecraft:air
execute as @e[tag=sgp.bench.assassin_attacker,type=husk] at @s run setblock ~ ~ ~-1 minecraft:air
kill @e[tag=sgp.bench.assassin_attacker,type=husk]
kill @e[type=ender_pearl]
kill @e[type=endermite]
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
