#> sgp.kits:tnt_tracking/setup_pairing
# @dummy
# @environment sgp.ci:tnt_tracking/setup_pairing
#
# Setup links to the freshly spawned TNT even when an older charge occupies the exact same position.

gamemode creative @s
tp @s ~0.5 ~1 ~0.5 0 0
summon tnt ~2 ~ ~ {Tags:["sgp.tnt","sgp.ci.tnt_charge_b"],fuse:100s,NoGravity:1b,Motion:[0.0d,0.0d,0.0d]}
summon tnt ~2 ~ ~ {Tags:["sgp.tnt","sgp.new","sgp.ci.tnt_charge_a"],fuse:100s,NoGravity:1b,Motion:[0.0d,0.0d,0.0d]}
summon interaction ~2 ~ ~ {Tags:["sgp.tnt_interaction","sgp.new","sgp.ci.tnt_interaction_a"],width:1.1f,height:1.1f}
execute as @e[tag=sgp.ci.tnt_interaction_a,type=interaction] run function sgp.kits:abilities/tnt/setup_interaction
execute unless score @e[tag=sgp.ci.tnt_interaction_a,limit=1,type=interaction] bs.link.to = @e[tag=sgp.ci.tnt_charge_a,limit=1,type=tnt] bs.id run fail "The interaction did not link to the freshly spawned charge"
