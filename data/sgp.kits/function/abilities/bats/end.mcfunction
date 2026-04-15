#> sgp.kits:abilities/bats/end

tag @s add sgp.processing
execute at @s summon armor_stand run function sgp.kits:abilities/bats/restore/equipment
tag @s remove sgp.processing