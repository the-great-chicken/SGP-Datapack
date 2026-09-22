#> sgp.kits:abilities/bats/tick
#
# Keep equipment hidden while active and restore it when the ability ends.

execute if score @s sgp.duration_ability matches 1 run return run function sgp.kits:abilities/bats/end

execute if items entity @s weapon.mainhand * unless items entity @s weapon.mainhand *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}] run function sgp.kits:abilities/bats/hide/current_held_item {slot:weapon.mainhand}
execute if items entity @s weapon.offhand * unless items entity @s weapon.offhand *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}] run function sgp.kits:abilities/bats/hide/current_held_item {slot:weapon.offhand}
