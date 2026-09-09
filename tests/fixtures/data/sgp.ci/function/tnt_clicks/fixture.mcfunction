#> sgp.ci:tnt_clicks/fixture

gamemode creative @s
tp @s ~0.5 ~1 ~0.5 0 0
summon tnt ~2.5 ~1 ~0.5 {Tags:["sgp.tnt","sgp.ci.click_tnt_a"],fuse:100s,NoGravity:1b,Motion:[0.0d,0.0d,0.0d]}
summon interaction ~2.5 ~1 ~0.5 {Tags:["sgp.tnt_interaction","sgp.new","sgp.ci.click_a"],width:1.1f,height:1.1f}
execute as @e[tag=sgp.ci.click_a,type=interaction] at @s run function sgp.kits:abilities/tnt/setup_interaction
assert entity @e[tag=sgp.ci.click_a,tag=bs.interaction.listen_left_click,tag=!sgp.new,type=interaction]
execute unless score @e[tag=sgp.ci.click_a,limit=1,type=interaction] bs.link.to = @e[tag=sgp.ci.click_tnt_a,limit=1,type=tnt] bs.id run fail "The interaction was not linked to its charge"
summon tnt ~1.5 ~1 ~0.5 {Tags:["sgp.tnt","sgp.ci.click_tnt_b"],fuse:100s,NoGravity:1b,Motion:[0.0d,0.0d,0.0d]}
summon interaction ~1.5 ~1 ~0.5 {Tags:["sgp.tnt_interaction","sgp.new","sgp.ci.click_b"],width:1.1f,height:1.1f}
execute as @e[tag=sgp.ci.click_b,type=interaction] at @s run function sgp.kits:abilities/tnt/setup_interaction
execute unless score @e[tag=sgp.ci.click_b,limit=1,type=interaction] bs.link.to = @e[tag=sgp.ci.click_tnt_b,limit=1,type=tnt] bs.id run fail "The second interaction was not linked to its charge"
