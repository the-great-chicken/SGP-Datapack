#> sgp.lore:_stun_all_players
# `{s: int}`
# 
# Stuns the players for `<s>` seconds, making them invulnerable
# and unable to deal damage

$execute as @a run function sgp.misc:stun/apply {duration:$(s)}
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl ambient @s ~ ~ ~ 100