#> sgp.ci:diorama_lifecycle/cleanup
# Remove lifecycle mannequins and passengers, including entities moved below the world during removal.

function sgp.ci:players/cleanup
execute as @e[tag=sgp.small_mannequin_96001,type=mannequin] on passengers run kill @s
execute as @e[tag=sgp.giant_mannequin_96001,type=mannequin] on passengers run kill @s
tp @e[tag=sgp.small_mannequin_96001,type=mannequin] 8.0 -1000.0 8.0
tp @e[tag=sgp.giant_mannequin_96001,type=mannequin] 8.0 -1000.0 8.0
kill @e[tag=sgp.small_mannequin_96001,type=mannequin]
kill @e[tag=sgp.giant_mannequin_96001,type=mannequin]
tag @e[tag=sgp.small_mannequin_96001,type=mannequin] remove sgp.small_mannequin_96001
tag @e[tag=sgp.giant_mannequin_96001,type=mannequin] remove sgp.giant_mannequin_96001
kill @e[tag=sgp.ci.diorama_lifecycle,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
