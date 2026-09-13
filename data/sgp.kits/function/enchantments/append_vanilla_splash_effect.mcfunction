#> sgp.kits:enchantments/append_vanilla_splash_effect
#
# Keep the intentionally small set of vanilla tipped-arrow mappings used by SGP.

execute if data entity @s {item:{components:{"minecraft:potion_contents":{potion:"minecraft:long_poison"}}}} \
    run data modify storage sgp:macro splash_arrow.custom_effects append value {id:"minecraft:poison",amplifier:0,duration:220}
execute if data entity @s {item:{components:{"minecraft:potion_contents":{potion:"minecraft:harming"}}}} \
    run data modify storage sgp:macro splash_arrow.custom_effects append value {id:"minecraft:instant_damage",amplifier:0,duration:220}
execute if data entity @s {item:{components:{"minecraft:potion_contents":{potion:"minecraft:slowness"}}}} \
    run data modify storage sgp:macro splash_arrow.custom_effects append value {id:"minecraft:slowness",amplifier:0,duration:220}
