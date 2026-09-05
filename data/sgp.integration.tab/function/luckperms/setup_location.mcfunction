#> sgp.integration.tab:luckperms/setup_location
# `{lieu, lieu_propre, couleur}`; executed with the server command source.
# Labels longer than ten characters become their first nine characters + '.'.

$luckperms creategroup sgp-loc-$(lieu)

data modify storage sgp:macro tab.location_setup set from storage sgp:macro tab.location_setup_marker
data modify storage sgp:macro tab.location_setup.label set from storage sgp:macro tab.location_setup.lieu_propre
data modify storage sgp:macro tab.location_setup.ending set value ""

execute store result score #tab_label_length sgp.dummy run data get storage sgp:macro tab.location_setup.label
execute if score #tab_label_length sgp.dummy matches 11.. run data modify storage sgp:macro tab.location_setup.label set string storage sgp:macro tab.location_setup.lieu_propre 0 9
execute if score #tab_label_length sgp.dummy matches 11.. run data modify storage sgp:macro tab.location_setup.ending set value "."

data modify storage sgp:macro tab.location_setup.color_code set value "&7"
execute if data storage sgp:macro tab.location_setup{couleur:"black"} run data modify storage sgp:macro tab.location_setup.color_code set value "&0"
execute if data storage sgp:macro tab.location_setup{couleur:"dark_blue"} run data modify storage sgp:macro tab.location_setup.color_code set value "&1"
execute if data storage sgp:macro tab.location_setup{couleur:"dark_green"} run data modify storage sgp:macro tab.location_setup.color_code set value "&2"
execute if data storage sgp:macro tab.location_setup{couleur:"dark_aqua"} run data modify storage sgp:macro tab.location_setup.color_code set value "&3"
execute if data storage sgp:macro tab.location_setup{couleur:"dark_red"} run data modify storage sgp:macro tab.location_setup.color_code set value "&4"
execute if data storage sgp:macro tab.location_setup{couleur:"dark_purple"} run data modify storage sgp:macro tab.location_setup.color_code set value "&5"
execute if data storage sgp:macro tab.location_setup{couleur:"gold"} run data modify storage sgp:macro tab.location_setup.color_code set value "&6"
execute if data storage sgp:macro tab.location_setup{couleur:"gray"} run data modify storage sgp:macro tab.location_setup.color_code set value "&7"
execute if data storage sgp:macro tab.location_setup{couleur:"dark_gray"} run data modify storage sgp:macro tab.location_setup.color_code set value "&8"
execute if data storage sgp:macro tab.location_setup{couleur:"blue"} run data modify storage sgp:macro tab.location_setup.color_code set value "&9"
execute if data storage sgp:macro tab.location_setup{couleur:"green"} run data modify storage sgp:macro tab.location_setup.color_code set value "&a"
execute if data storage sgp:macro tab.location_setup{couleur:"aqua"} run data modify storage sgp:macro tab.location_setup.color_code set value "&b"
execute if data storage sgp:macro tab.location_setup{couleur:"red"} run data modify storage sgp:macro tab.location_setup.color_code set value "&c"
execute if data storage sgp:macro tab.location_setup{couleur:"light_purple"} run data modify storage sgp:macro tab.location_setup.color_code set value "&d"
execute if data storage sgp:macro tab.location_setup{couleur:"yellow"} run data modify storage sgp:macro tab.location_setup.color_code set value "&e"
execute if data storage sgp:macro tab.location_setup{couleur:"white"} run data modify storage sgp:macro tab.location_setup.color_code set value "&f"

data modify storage sgp:macro tab.location_setup.first_color_character set value ""
data modify storage sgp:macro tab.location_setup.first_color_character set string storage sgp:macro tab.location_setup.couleur 0 1
execute if data storage sgp:macro tab.location_setup{first_color_character:"#"} run function sgp.integration.tab:luckperms/set_location_suffix_hex with storage sgp:macro tab.location_setup
execute unless data storage sgp:macro tab.location_setup{first_color_character:"#"} run function sgp.integration.tab:luckperms/set_location_suffix_named with storage sgp:macro tab.location_setup

$luckperms track sgp-location append sgp-loc-$(lieu)
