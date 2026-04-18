#> sgp.majeurs:hide_and_seek/role/effect/seeker
#
# give effect to the seeker

function sgp.majeurs:hide_and_seek/stun/unstun
effect give @s speed infinite 1 true
effect give @s jump_boost infinite 1 true
give @s stone_axe[tooltip_display={hidden_components:["attribute_modifiers"]}, unbreakable={}] 1
give @s ender_pearl[tooltip_display={hidden_components:["attribute_modifiers","enchantments"]}, enchantments={"sgp.kits:perfect_accuracy":1}, enchantment_glint_override=false] 8