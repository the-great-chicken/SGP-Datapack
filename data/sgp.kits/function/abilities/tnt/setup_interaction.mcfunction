#> sgp.kits:abilities/tnt/setup_interaction

execute at @n[tag=sgp.tnt,distance=..1,limit=1,type=tnt] run function #bs.link:create_link_ata
function #bs.interaction:on_left_click { run: "function sgp.kits:abilities/tnt/on_hit", executor: source }
tag @s remove sgp.new