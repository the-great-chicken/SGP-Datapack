#> sgp.ci:repulsion/scenarios/facing/1

execute as @e[tag=sgp.ci.repulsion,type=husk] at @s run tp @s ~ ~ ~ 90 0
scoreboard players set @e[tag=sgp.ci.repulsion,tag=!sgp.ci.repulsion_peer,type=husk] sgp.trigger_repulsion 1
