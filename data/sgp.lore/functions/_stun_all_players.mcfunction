#> sgp.lore:_stun_all_players
# `{s: int}`
# 
# Stuns the players for `<s>` seconds, making them invulnerable
# and unable to deal damage

$effect give @a minecraft:slowness $(s) 100 true
$effect give @a minecraft:jump_boost $(s) 200 true
$effect give @a minecraft:blindness $(s) 255 true
$effect give @a minecraft:weakness $(s) 255 true
$effect give @a minecraft:resistance $(s) 255 true
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl ambient @s ~ ~ ~ 100