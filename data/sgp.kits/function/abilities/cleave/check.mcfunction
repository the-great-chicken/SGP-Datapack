#> sgp.kits:abilities/cleave/check

# Check if this target's position is within a 180-degree cone of the attacker
execute as @a[tag=sgp.attacker,limit=1] store result score #result bs.data run function #bs.view:in_view_ata {angle:120}

# If the target is inside the 180-degree semi-circle (score = 1), deal damage to it
execute if score #result bs.data matches 1 run function sgp.kits:abilities/cleave/compute_damage