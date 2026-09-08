#> sgp.ci:illusions_movement/clear

kill @e[tag=sgp.ci.illusion,type=marker]
execute as @e[tag=sgp.ci.illusion,type=mannequin] at @s run tp @s ~ -1000 ~
kill @e[tag=sgp.ci.illusion,type=mannequin]
