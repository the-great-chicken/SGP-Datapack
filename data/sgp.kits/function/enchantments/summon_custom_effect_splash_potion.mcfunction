#> sgp.kits:enchantments/summon_custom_effect_splash_potion
# {custom_effects}
# Initialize the new potion directly so nearby potions cannot receive its effects.

$summon splash_potion ~ ~0.5 ~ {Item:{id:"minecraft:splash_potion",count:1,components:{"minecraft:potion_contents":{custom_effects:$(custom_effects)}}},Motion:[0.0,-10.0,0.0]}
