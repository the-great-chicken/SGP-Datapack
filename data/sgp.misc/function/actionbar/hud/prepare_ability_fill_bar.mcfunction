#> sgp.misc:actionbar/hud/prepare_ability_fill_bar
# `{key: translation_key}`
#
# Selects the player's kit color, then appends the current fill glyph.
# The color source is the existing sgp:kits storage, so kit color changes only
# need to be made in one place.

$data modify storage sgp:macro actionbar_ability_fill set value {key:"$(key)",color:"white"}

execute if score @s sgp.kit_id matches 0 run data modify storage sgp:macro actionbar_ability_fill.color set from storage sgp:kits pigeon.kit_color
execute if score @s sgp.kit_id matches 1 run data modify storage sgp:macro actionbar_ability_fill.color set from storage sgp:kits combattant.kit_color
execute if score @s sgp.kit_id matches 2 run data modify storage sgp:macro actionbar_ability_fill.color set from storage sgp:kits archer.kit_color
execute if score @s sgp.kit_id matches 3 run data modify storage sgp:macro actionbar_ability_fill.color set from storage sgp:kits vindicateur.kit_color
execute if score @s sgp.kit_id matches 4 run data modify storage sgp:macro actionbar_ability_fill.color set from storage sgp:kits pyromane.kit_color
execute if score @s sgp.kit_id matches 5 run data modify storage sgp:macro actionbar_ability_fill.color set from storage sgp:kits tank.kit_color
execute if score @s sgp.kit_id matches 6 run data modify storage sgp:macro actionbar_ability_fill.color set from storage sgp:kits roi.kit_color
execute if score @s sgp.kit_id matches 7 run data modify storage sgp:macro actionbar_ability_fill.color set from storage sgp:kits eclaireur.kit_color
execute if score @s sgp.kit_id matches 8 run data modify storage sgp:macro actionbar_ability_fill.color set from storage sgp:kits alchimiste.kit_color
execute if score @s sgp.kit_id matches 9 run data modify storage sgp:macro actionbar_ability_fill.color set from storage sgp:kits enderman.kit_color
execute if score @s sgp.kit_id matches 10 run data modify storage sgp:macro actionbar_ability_fill.color set from storage sgp:kits cancer.kit_color
execute if score @s sgp.kit_id matches 11 run data modify storage sgp:macro actionbar_ability_fill.color set from storage sgp:kits poseidon.kit_color

function sgp.misc:actionbar/hud/append_ability_fill_bar with storage sgp:macro actionbar_ability_fill
data remove storage sgp:macro actionbar_ability_fill
