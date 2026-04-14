#> sgp.kits:abilities/illusions/as_center

function #bs.position:get_relative_ata {scale:1000}

scoreboard players operation $px bs.in = @s bs.pos.x
scoreboard players operation $py bs.in = @s bs.pos.y
scoreboard players operation $pz bs.in = @s bs.pos.z

execute positioned as @s as @e[predicate=bs.link:link_equal,type=mannequin,limit=3] run function sgp.kits:abilities/illusions/apply_offset