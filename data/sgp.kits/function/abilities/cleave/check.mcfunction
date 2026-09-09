#> sgp.kits:abilities/cleave/check

# Check whether the target is within the attacker's 120-degree cone.
execute as @a[tag=sgp.attacker,limit=1] store result score #result bs.data run function #bs.view:in_view_ata {angle:120}

# Deal damage to targets inside the cone.
execute if score #result bs.data matches 1 run damage @s 5 sgp.kits:giant_sweep by @p[tag=sgp.attacker] from @p[tag=sgp.attacker]
