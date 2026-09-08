#> sgp.ci:interaction_dispatch/fixture

execute as @a[tag=sgp.ci.interaction_actor] run dummy @s leave
kill @e[tag=sgp.ci.interaction,type=interaction]
tag @s add sgp.ci.interaction_actor
gamemode creative @s
clear @s
scoreboard players set @s sgp.dummy 0
tp @s ~0.5 ~1 ~0.5
summon interaction ~2.5 ~1 ~0.5 {Tags:["sgp.ci.interaction","sgp.ci.interaction_first","sgp.interaction"],data:{function:"sgp.ci:interaction_dispatch/reward",args:{item:"diamond",count:3}}}
summon interaction ~4.5 ~1 ~0.5 {Tags:["sgp.ci.interaction","sgp.ci.interaction_second","sgp.interaction"],data:{function:"sgp.ci:interaction_dispatch/reward",args:{item:"emerald",count:7}}}
