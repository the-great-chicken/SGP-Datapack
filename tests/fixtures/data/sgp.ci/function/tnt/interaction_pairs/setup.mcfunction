#> sgp.ci:tnt/interaction_pairs/setup
# Create two independently linked TNT charge/interaction pairs shared by TNT behavior tests.

gamemode creative @s
tp @s ~0.5 ~1 ~0.5 0 0
summon tnt ~2.5 ~1 ~0.5 {Tags:["sgp.tnt","sgp.ci.tnt_charge_a"],fuse:100s,NoGravity:1b,Motion:[0.0d,0.0d,0.0d]}
summon interaction ~2.5 ~1 ~0.5 {Tags:["sgp.tnt_interaction","sgp.new","sgp.ci.tnt_interaction_a"],width:1.1f,height:1.1f}
execute as @e[tag=sgp.ci.tnt_interaction_a,type=interaction] at @s run function sgp.kits:abilities/tnt/setup_interaction
assert entity @e[tag=sgp.ci.tnt_interaction_a,tag=bs.interaction.listen_left_click,tag=!sgp.new,type=interaction]
execute unless score @e[tag=sgp.ci.tnt_interaction_a,limit=1,type=interaction] bs.link.to = @e[tag=sgp.ci.tnt_charge_a,limit=1,type=tnt] bs.id run fail "The interaction was not linked to its charge"
summon tnt ~1.5 ~1 ~0.5 {Tags:["sgp.tnt","sgp.ci.tnt_charge_b"],fuse:100s,NoGravity:1b,Motion:[0.0d,0.0d,0.0d]}
summon interaction ~1.5 ~1 ~0.5 {Tags:["sgp.tnt_interaction","sgp.new","sgp.ci.tnt_interaction_b"],width:1.1f,height:1.1f}
execute as @e[tag=sgp.ci.tnt_interaction_b,type=interaction] at @s run function sgp.kits:abilities/tnt/setup_interaction
execute unless score @e[tag=sgp.ci.tnt_interaction_b,limit=1,type=interaction] bs.link.to = @e[tag=sgp.ci.tnt_charge_b,limit=1,type=tnt] bs.id run fail "The second interaction was not linked to its charge"
