#> sgp.misc:interactions/execute

advancement revoke @s only sgp.misc:interaction

tag @s add sgp.interacting
execute as @e[tag=sgp.interaction,distance=..6,type=interaction] if function sgp.misc:interactions/is_my_target \
    run return run function sgp.misc:interactions/run_macro with entity @s data