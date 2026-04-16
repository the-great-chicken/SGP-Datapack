#> sgp.kits:abilities/tnt/setup_interaction

execute at @n[tag=sgp.tnt,distance=..1,limit=1,type=tnt] run function #bs.link:create_link_ata
function #bs.interaction:on_left_click { run: "execute at @s as @n[tag=sgp.tnt,distance=..5,limit=1,type=tnt] run function sgp.kits:abilities/tnt/apply_kb", executor: source }
tag @s remove sgp.new