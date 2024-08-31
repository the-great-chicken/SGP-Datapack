#> sgp.majeurs:hide_and_seek/role/effect/seeker
#
# give effect to the seeker

function sgp.majeurs:hide_and_seek/stun/unstun
effect give @s speed infinite 1 true
effect give @s jump_boost infinite 1 true
give @s stone_axe[hide_tooltip={},unbreakable={show_in_tooltip:false}] 1
give @s ender_pearl[hide_tooltip={}] 8