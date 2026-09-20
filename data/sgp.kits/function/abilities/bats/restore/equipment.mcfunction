#> sgp.kits:abilities/bats/restore/equipment

# Setup the armor stand properties so it is safe and invisible
data merge entity @s {Invisible:1b, Marker:1b, drop_chances:{head:0.0f,chest:0.0f,legs:0.0f,feet:0.0f,mainhand:0.0f,offhand:0.0f}}

# --- RESTORE ARMOR (Chest, Legs, Feet) ---
function sgp.kits:abilities/bats/restore/armor_item {slot:chest}
function sgp.kits:abilities/bats/restore/armor_item {slot:legs}
function sgp.kits:abilities/bats/restore/armor_item {slot:feet}


# --- RESTORE HELMET (Head) ---
function sgp.kits:abilities/bats/restore/helmet


# --- RESTORE HELD ITEMS (Mainhand, Offhand) ---
# Hidden items can move between hotbar/offhand slots while the ability is active, so locate the marked stacks rather than rewriting every slot unconditionally.
execute if items entity @p[tag=sgp.processing] hotbar.0 *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}] run function sgp.kits:abilities/bats/restore/held_item {slot:"hotbar.0"}
execute if items entity @p[tag=sgp.processing] hotbar.1 *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}] run function sgp.kits:abilities/bats/restore/held_item {slot:"hotbar.1"}
execute if items entity @p[tag=sgp.processing] hotbar.2 *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}] run function sgp.kits:abilities/bats/restore/held_item {slot:"hotbar.2"}
execute if items entity @p[tag=sgp.processing] hotbar.3 *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}] run function sgp.kits:abilities/bats/restore/held_item {slot:"hotbar.3"}
execute if items entity @p[tag=sgp.processing] hotbar.4 *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}] run function sgp.kits:abilities/bats/restore/held_item {slot:"hotbar.4"}
execute if items entity @p[tag=sgp.processing] hotbar.5 *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}] run function sgp.kits:abilities/bats/restore/held_item {slot:"hotbar.5"}
execute if items entity @p[tag=sgp.processing] hotbar.6 *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}] run function sgp.kits:abilities/bats/restore/held_item {slot:"hotbar.6"}
execute if items entity @p[tag=sgp.processing] hotbar.7 *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}] run function sgp.kits:abilities/bats/restore/held_item {slot:"hotbar.7"}
execute if items entity @p[tag=sgp.processing] hotbar.8 *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}] run function sgp.kits:abilities/bats/restore/held_item {slot:"hotbar.8"}
execute if items entity @p[tag=sgp.processing] weapon.offhand *[custom_data~{hidden_special:1b}|custom_data~{hidden_vanilla:1b}] run function sgp.kits:abilities/bats/restore/held_item {slot:"weapon.offhand"}


kill @s
