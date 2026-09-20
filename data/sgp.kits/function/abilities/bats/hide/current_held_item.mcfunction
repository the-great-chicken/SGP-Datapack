#> sgp.kits:abilities/bats/hide/current_held_item
# `{slot: player item_slot}`
#
# Hide one newly equipped held stack without touching the rest of the inventory.

tag @s add sgp.processing
$execute at @s summon armor_stand run function sgp.kits:abilities/bats/hide/current_held_item_on_stand {slot:$(slot)}
tag @s remove sgp.processing
